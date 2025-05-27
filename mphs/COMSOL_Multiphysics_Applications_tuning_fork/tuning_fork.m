function out = model
%
% tuning_fork.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);

model.param.set('Lp', '75[mm]');
model.param.descr('Lp', 'Prong length');
model.param.set('rb', '5.5[mm]');
model.param.descr('rb', 'Base radius');
model.param.set('rp', '2.5[mm]');
model.param.descr('rp', 'Prong radius');
model.param.set('Lh', '40[mm]');
model.param.descr('Lh', 'Handle length');

model.geom('geom1').repairTolType('relative');
model.geom('geom1').scaleUnitValue(true);
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'rp');
model.geom('geom1').feature('cyl1').set('h', 'Lh');
model.geom('geom1').feature('cyl1').set('pos', {'rb' '0' '-Lh-rb'});
model.geom('geom1').run('cyl1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'rp*2');
model.geom('geom1').feature('sph1').set('pos', {'rb' '0' '-(rb+Lh)'});
model.geom('geom1').run('sph1');
model.geom('geom1').create('tor1', 'Torus');
model.geom('geom1').feature('tor1').set('rmaj', 'rb');
model.geom('geom1').feature('tor1').set('rmin', 'rp');
model.geom('geom1').feature('tor1').set('angle', 180);
model.geom('geom1').feature('tor1').set('pos', {'rb' '0' '0'});
model.geom('geom1').feature('tor1').set('axistype', 'cartesian');
model.geom('geom1').feature('tor1').set('ax3', [0 1 0]);
model.geom('geom1').feature('tor1').set('rot', -90);
model.geom('geom1').run('tor1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'sph1' 'tor1'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'rp');
model.geom('geom1').feature('cyl2').set('h', 'Lp');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'rp');
model.geom('geom1').feature('cyl3').set('h', 'Lp');
model.geom('geom1').feature('cyl3').set('pos', {'2*rb' '0' '0'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl2' 'cyl3' 'uni1'});
model.geom('geom1').feature('rot1').set('rot', 90);
model.geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.geom('geom1').run('fin');

model.view('view1').set('showaxisorientation', false);
model.view('view1').set('showmaterial', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat2').label('Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat3').label('Copper');
model.material('mat3').set('family', 'copper');
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.35');
model.material('mat3').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat3').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat3').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat3').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').label('Iron');
model.material('mat4').set('family', 'iron');
model.material('mat4').propertyGroup('def').set('relpermeability', {'4000' '0' '0' '0' '4000' '0' '0' '0' '4000'});
model.material('mat4').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('density', '7870[kg/m^3]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]'});
model.material('mat4').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.29');
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').label('Titanium beta-21S');
model.material('mat5').set('family', 'titanium');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '710[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('density', '4940[kg/m^3]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]'});
model.material('mat5').propertyGroup('Enu').set('E', '105[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.33');

model.physics('solid').prop('ShapeProperty').set('order_displacement', 2);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([10 18]);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '10[mm]');
model.mesh('mesh1').feature('size').set('hmin', '2[mm]');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([2 3]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 50);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').set('method', 'dellegacy52');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.2699999999999999E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').feature('e1').set('rtol', '1e-6');

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 7);
model.study('std1').feature('eig').set('shift', '0');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('e1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.2699999999999999E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'modeShape');
model.result('pg1').label('Mode Shape (solid)');
model.result('pg1').set('showlegends', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
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
model.result('pg1').set('looplevel', [7]);
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('edges', false);

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '0.0005');
model.result('pg1').run;
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'freq', 0);
model.result.numerical('gev1').setIndex('unit', 'Hz', 0);
model.result.numerical('gev1').setIndex('descr', 'Computed fundamental frequency:', 0);
model.result.numerical('gev1').setIndex('descr', '', 1);
model.result.numerical('gev1').setIndex('unit', '', 1);
model.result.numerical('gev1').label('Frequency');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('expr', 'Lp', 0);
model.result.numerical('gev2').setIndex('unit', '', 0);
model.result.numerical('gev2').setIndex('descr', 'Prong length', 0);
model.result.numerical('gev2').setIndex('descr', '', 1);
model.result.numerical('gev2').setIndex('unit', '', 1);
model.result.numerical('gev2').label('Prong length');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Frequency');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title([]);

model.description('');

model.label('tuning_fork_embedded.mph');

model.setExpectedComputationTime('4 seconds (frequency); 14 seconds (length)');

model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('templatesource', 'brief');
model.result.report('rpt1').set('filename', 'user:///tuning_fork.docx');
model.result.report('rpt1').set('numberformat', 'custom');
model.result.report('rpt1').set('precision', 4);
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').label('Tuning Fork');
model.result.report('rpt1').feature('tp1').set('author', '');
model.result.report('rpt1').feature('tp1').set('includeauthor', false);
model.result.report('rpt1').feature('tp1').set('includecompany', false);
model.result.report('rpt1').feature('tp1').set('includeversion', false);
model.result.report('rpt1').feature('tp1').set('summary', 'With this application you can specify the prong length of a tuning fork and compute the resulting fundamental eigenfrequency. Conversely, you can specify a target frequency and compute the corresponding prong length.');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').set('heading', 'Software Information');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('About the Software');
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').set('heading', 'Model Parameters');
model.result.report('rpt1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec2').feature('param1').label('Parameters in the Embedded Model');
model.result.report('rpt1').feature('sec2').feature.create('field1', 'BooleanDataField');
model.result.report('rpt1').feature('sec2').feature('field1').label('Find');
model.result.report('rpt1').feature('sec2').feature.create('field2', 'DoubleDataField');
model.result.report('rpt1').feature('sec2').feature('field2').label('Frequency and Prong Length Values');
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').set('heading', 'Results');
model.result.report('rpt1').feature('sec3').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').set('heading', 'Plot Groups');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').set('heading', 'Derived Values');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec1').feature('mtbl1').label('Computed Frequency');
model.result.report('rpt1').feature('sec3').feature('sec1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').set('heading', 'Visualization');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec3').feature('sec1').feature('sec2').feature('pg1').label('Mode Shape');
model.result('pg1').run;

model.title('Tuning Fork');

model.description(['This app demonstrates the following:' newline  newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Playing a sound at a specific computed frequency' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Selecting different materials from a combo box' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Choice of three different user interface layouts for computer, tablet, or smartphone' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Custom implementation of the secant method' newline  native2unicode(hex2dec({'20' '22'}), 'unicode') ' Custom window icon.' newline  newline 'When a tuning fork is struck, it vibrates in a complex motion pattern that can be described mathematically as the superposition of resonant modes, also known as eigenmodes. Each mode is associated with a particular eigenfrequency. The tuning fork produces its characteristic sound from the specific timbre that is created by the combination of all of the eigenfrequencies.' newline  newline 'The app computes the fundamental resonant frequency of a tuning fork where you can change the prong length. Alternatively, you can provide a user-defined target frequency and the application will find the corresponding prong length using an algorithm based on a secant method.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('tuning_fork.mph');

model.modelNode.label('Components');

out = model;
