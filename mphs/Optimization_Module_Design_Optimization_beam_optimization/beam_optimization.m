function out = model
%
% beam_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Design_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('L0', '1[m]');
model.param.descr('L0', 'Beam length');
model.param.set('T0', '20[cm]');
model.param.descr('T0', 'Beam height');
model.param.set('M0', 'L0*T0*2700[kg/m^3]');
model.param.descr('M0', 'Beam weight');
model.param.set('Yopt1', '0');
model.param.descr('Yopt1', 'Y position, point 1');
model.param.set('Yopt2', '0');
model.param.descr('Yopt2', 'Y position, point 2');
model.param.set('maxDisp', '0.2[mm]');
model.param.descr('maxDisp', 'Maximum displacement');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L0/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'Yopt1', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L0', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'Yopt2', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L0', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', '0.9*T0', 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L0', 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'T0', 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'L0', 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'T0', 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'T0', 6, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', '0.9*T0', 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'L0', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', '0.9*T0', 1, 1);
model.geom('geom1').run('pol2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Bottom Boundaries');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('ymax', 'eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel2', 'boxsel1');
model.geom('geom1').feature('boxsel2').label('Right Boundaries');
model.geom('geom1').feature('boxsel2').set('xmin', 'L0-eps');
model.geom('geom1').feature('boxsel2').set('ymax', Inf);
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('matlnk1', 'Link', 'comp1');

model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([1 3]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([5]);
model.physics('solid').feature('bndl1').set('LoadType', 'ForceLength');
model.physics('solid').feature('bndl1').set('FperLength', {'0' '-1e6[N/m]*((X/L0)^4*(1-X/L0))' '0'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.massProp.create('mass1', 'MassProperties');
model.massProp('mass1').model('comp1');
model.massProp('mass1').set('densitySource', 'fromPhysics');

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').label('Tip Displacement');
model.probe('point1').set('probename', 'pnt_disp');
model.probe('point1').selection.set([7]);

model.study('std1').feature('stat').set('probesel', 'none');
model.study('std1').label('Parameter Optimization');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Parameter Optimization');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Parameter Optimization - eval(mass1.mass) kg');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'solid.disp');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', '1.05*maxDisp');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 100);
model.result('pg1').run;
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('elemcolor', 'none');
model.result('pg1').feature('mesh1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('mesh1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('mesh1').feature('def1').set('scale', 100);
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').feature('line1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('line1').feature('def1').set('expr', {'u+solid.F_Ax' 'v+solid.F_Ay'});
model.result('pg1').feature('line1').feature('def1').set('descr', 'Displacement field + Load (spatial frame)');
model.result('pg1').feature('line1').feature('def1').setIndex('expr', 'u', 0);
model.result('pg1').feature('line1').feature('def1').set('expr', {'u' 'v-1e-8*solid.FperLengthy'});
model.result('pg1').feature('line1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('line1').feature('def1').set('scale', 100);
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'solid.FperLengthx' 'v'});
model.result('pg1').feature('arwl1').setIndex('expr', 'solid.FperLengthy', 1);
model.result('pg1').feature('arwl1').set('arrowbase', 'head');
model.result('pg1').feature('arwl1').set('scaleactive', true);
model.result('pg1').feature('arwl1').set('scale', '1e-6');
model.result('pg1').feature('arwl1').set('arrowcount', 160);
model.result('pg1').feature('arwl1').set('color', 'black');
model.result('pg1').feature('arwl1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('arwl1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('arwl1').feature('def1').set('scale', 100);
model.result('pg1').run;

model.study('std1').create('opt', 'Optimization');
model.study('std1').feature('opt').set('optsolver', 'cobyla');
model.study('std1').feature('opt').set('optobj', {'comp1.mass1.mass'});
model.study('std1').feature('opt').set('descr', {'Mass'});
model.study('std1').feature('opt').set('objectivescaling', 'init');
model.study('std1').feature('opt').setIndex('pname', 'L0', 0);
model.study('std1').feature('opt').setIndex('initval', '1[m]', 0);
model.study('std1').feature('opt').setIndex('scale', 1, 0);
model.study('std1').feature('opt').setIndex('lbound', '', 0);
model.study('std1').feature('opt').setIndex('ubound', '', 0);
model.study('std1').feature('opt').setIndex('pname', 'L0', 0);
model.study('std1').feature('opt').setIndex('initval', '1[m]', 0);
model.study('std1').feature('opt').setIndex('scale', 1, 0);
model.study('std1').feature('opt').setIndex('lbound', '', 0);
model.study('std1').feature('opt').setIndex('ubound', '', 0);
model.study('std1').feature('opt').setIndex('pname', 'T0', 1);
model.study('std1').feature('opt').setIndex('initval', '20[cm]', 1);
model.study('std1').feature('opt').setIndex('scale', 1, 1);
model.study('std1').feature('opt').setIndex('lbound', '', 1);
model.study('std1').feature('opt').setIndex('ubound', '', 1);
model.study('std1').feature('opt').setIndex('pname', 'T0', 1);
model.study('std1').feature('opt').setIndex('initval', '20[cm]', 1);
model.study('std1').feature('opt').setIndex('scale', 1, 1);
model.study('std1').feature('opt').setIndex('lbound', '', 1);
model.study('std1').feature('opt').setIndex('ubound', '', 1);
model.study('std1').feature('opt').setIndex('pname', 'Yopt1', 0);
model.study('std1').feature('opt').setIndex('initval', 0, 0);
model.study('std1').feature('opt').setIndex('scale', 1, 0);
model.study('std1').feature('opt').setIndex('lbound', 0, 0);
model.study('std1').feature('opt').setIndex('ubound', '0.9*T0', 0);
model.study('std1').feature('opt').setIndex('pname', 'Yopt2', 1);
model.study('std1').feature('opt').setIndex('initval', 0, 1);
model.study('std1').feature('opt').setIndex('scale', 1, 1);
model.study('std1').feature('opt').setIndex('lbound', 0, 1);
model.study('std1').feature('opt').setIndex('ubound', '0.9*T0', 1);
model.study('std1').feature('opt').set('constraintExpression', {'comp1.pnt_disp'});
model.study('std1').feature('opt').setIndex('constraintExpression', 'comp1.pnt_disp/maxDisp', 0);
model.study('std1').feature('opt').setIndex('constraintUbound', 1, 0);
model.study('std1').feature('opt').set('plot', true);
model.study('std1').feature('opt').set('probesel', 'none');
model.study('std1').feature('opt').set('keepsol', 'last');
model.study('std1').setGenPlots(false);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('o1', 'Optimization');
model.batch('o1').study('std1');
model.batch('p1').study('std1');
model.batch('o1').attach('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').attach('std1');
model.batch('p1').set('optimization', 'o1');
model.batch('p1').set('err', 'on');
model.batch('p1').set('control', 'opt');
model.batch('o1').set('parametricjobs', {'p1'});

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('o1').run('compute');

model.result('pg1').run;

model.study('std1').feature('opt').set('probewindow', '');

model.common.create('fsd1', 'FreeShapeDomain', 'comp1');
model.common('fsd1').selection.all;

model.geom('geom1').run;

model.common.create('poly1', 'PolynomialBoundary', 'comp1');
model.common('poly1').selection.named('geom1_boxsel1');
model.common('poly1').set('symmetryContinuity', 'Disabled');
model.common('poly1').set('internalPolynomialContinuity', 'Enabled');
model.common('poly1').set('maximumDisplacement', '0.9*T0');
model.common.create('fsr1', 'FreeShapeSymmetry', 'comp1');
model.common('fsr1').selection.named('geom1_boxsel2');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').feature('stat').set('probesel', 'none');
model.study('std2').setGenPlots(false);
model.study('std2').label('Shape Optimization');

model.sol.create('sol4');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol4').study('std2');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std2');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_material_disp').set('scaleval', '0.009935361090569382');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std2');
model.sol('sol4').runAll;

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Shape Optimization');
model.result('pg2').set('title', 'Shape Optimization - eval(mass1.mass) kg');
model.result('pg2').set('data', 'dset4');

model.study('std2').create('sho', 'ShapeOptimization');
model.study('std2').feature('sho').set('mmamaxiter', 20);
model.study('std2').feature('sho').set('optobj', {'comp1.mass1.mass'});
model.study('std2').feature('sho').set('descr', {'Mass'});
model.study('std2').feature('sho').set('objectivescaling', 'init');
model.study('std2').feature('sho').set('constraintExpression', {'comp1.pnt_disp'});
model.study('std2').feature('sho').setIndex('constraintExpression', 'comp1.pnt_disp/maxDisp', 0);
model.study('std2').feature('sho').setIndex('constraintLbound', '', 0);
model.study('std2').feature('sho').setIndex('constraintUbound', '', 0);
model.study('std2').feature('sho').setIndex('constraintUbound', 1, 0);
model.study('std2').feature('sho').set('probesel', 'none');
model.study('std2').feature('sho').set('plot', true);
model.study('std2').feature('sho').set('plotgroup', 'pg2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol4').study('std2');
model.sol('sol4').feature.remove('s1');
model.sol('sol4').feature.remove('v1');
model.sol('sol4').feature.remove('st1');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std2');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol4').feature('v1').feature('comp1_material_disp').set('scaleval', '0.009935361090569382');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('o1', 'Optimization');
model.sol('sol4').feature('o1').set('control', 'sho');
model.sol('sol4').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol4').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol4').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol4').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std2');
model.sol('sol4').runAll;

model.result('pg2').run;

model.study('std2').feature('sho').set('probewindow', '');

model.result('pg2').run;

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').selection.set([1]);
model.common('dtopo1').set('discretization', 'constant');
model.common('dtopo1').set('theta_0', '1');
model.common.create('ftopom1', 'MaterialTopologyDomain', 'comp1');
model.common('ftopom1').selection.set([2]);

model.material.create('toplnk1', 'TopologyLink', 'comp1');
model.material('toplnk1').selection.all;
model.material('toplnk1').set('topologySource', 'dtopo1');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').label('Topology Optimization');
model.study('std3').setGenPlots(false);
model.study('std3').feature('stat').setEntry('activate', 'frame:material1', false);
model.study('std3').feature('stat').set('probesel', 'none');

model.sol.create('sol5');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol5').study('std3');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std3');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scaleval', '0.009935361090569382');
model.sol('sol5').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('s1').create('seDef', 'Segregated');
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').feature('s1').feature.remove('seDef');
model.sol('sol5').attach('std3');
model.sol('sol5').runAll;

model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Topology Optimization');
model.result('pg3').set('title', 'Topology Optimization - eval(mass1.mass) kg');
model.result('pg3').set('data', 'dset5');
model.result('pg3').run;
model.result('pg3').feature('surf1').create('filt1', 'Filter');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('filt1').set('expr', '0.5<dtopo1.theta');

model.study('std3').create('topo', 'TopologyOptimization');
model.study('std3').feature('topo').set('mmamaxiter', 50);
model.study('std3').feature('topo').set('optobj', {'comp1.mass1.mass'});
model.study('std3').feature('topo').set('descr', {'Mass'});
model.study('std3').feature('topo').set('objectivescaling', 'init');
model.study('std3').feature('topo').setEntry('controlVariableActive', 'poly1', false);
model.study('std3').feature('topo').set('constraintExpression', {'comp1.pnt_disp'});
model.study('std3').feature('topo').setIndex('constraintExpression', 'comp1.pnt_disp/maxDisp', 0);
model.study('std3').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std3').feature('topo').setIndex('constraintUbound', '', 0);
model.study('std3').feature('topo').setIndex('constraintUbound', 1, 0);
model.study('std3').feature('topo').set('probesel', 'none');
model.study('std3').feature('topo').set('plot', true);
model.study('std3').feature('topo').set('plotgroup', 'pg3');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol5').study('std3');
model.sol('sol5').feature.remove('s1');
model.sol('sol5').feature.remove('v1');
model.sol('sol5').feature.remove('st1');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std3');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_material_disp').set('scaleval', '0.009935361090569382');
model.sol('sol5').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('o1', 'Optimization');
model.sol('sol5').feature('o1').set('control', 'topo');
model.sol('sol5').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol5').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol5').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol5').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol5').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol5').attach('std3');
model.sol('sol5').runAll;

model.result('pg3').run;

model.study('std3').feature('topo').set('probewindow', '');
model.study('std1').feature('opt').setEntry('controlVariableActive', 'dtopo1.theta_c', false);
model.study('std1').feature('opt').setEntry('controlVariableActive', 'poly1', false);
model.study('std2').feature('sho').setEntry('controlVariableActive', 'dtopo1.theta_c', false);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').setSolveFor('/common/dtopo1', false);
model.study('std1').feature('stat').setSolveFor('/frame/material1', false);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').setSolveFor('/common/dtopo1', false);

model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('Thumbnail');
model.result('pg4').set('titletype', 'none');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg4').run;
model.result('pg4').set('showlegends', false);
model.result('pg4').feature.copy('surf2', 'pg2/surf1');
model.result('pg4').feature.copy('mesh2', 'pg2/mesh1');
model.result('pg4').feature.copy('line2', 'pg2/line1');
model.result('pg4').feature.copy('arwl2', 'pg2/arwl1');
model.result('pg4').run;
model.result('pg4').feature('surf2').set('data', 'dset4');
model.result('pg4').run;
model.result('pg4').feature('surf2').feature('def').set('expr', {'u' 'v-2.5e-3'});
model.result('pg4').run;
model.result('pg4').feature('mesh2').set('data', 'dset4');
model.result('pg4').run;
model.result('pg4').feature('mesh2').feature('def1').set('expr', {'u' 'v-2.5e-3'});
model.result('pg4').run;
model.result('pg4').feature('line2').set('data', 'dset4');
model.result('pg4').run;
model.result('pg4').feature('line2').feature('def1').set('expr', {'u' '-1e-8*solid.FperLengthy+v-2.5e-3'});
model.result('pg4').run;
model.result('pg4').feature('arwl2').set('data', 'dset4');
model.result('pg4').run;
model.result('pg4').feature('arwl2').feature('def1').set('expr', {'u' 'v-2.5e-3'});
model.result('pg3').run;
model.result('pg3').feature('surf1').set('data', 'dset5');
model.result('pg4').run;
model.result('pg4').feature.copy('surf3', 'pg3/surf1');
model.result('pg4').feature.copy('mesh3', 'pg3/mesh1');
model.result('pg4').feature.copy('line3', 'pg3/line1');
model.result('pg4').feature.copy('arwl3', 'pg3/arwl1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf3').feature('def').set('expr', {'u' 'v-5e-3'});
model.result('pg3').run;
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg4').run;
model.result('pg4').feature('mesh3').set('data', 'dset5');
model.result('pg4').run;
model.result('pg4').feature('mesh3').feature('def1').set('expr', {'u' 'v-5e-3'});
model.result('pg4').run;
model.result('pg4').feature('line3').set('data', 'dset5');
model.result('pg4').run;
model.result('pg4').feature('line3').feature('def1').set('expr', {'u' '-1e-8*solid.FperLengthy+v-5e-3'});
model.result('pg4').run;
model.result('pg4').feature('arwl3').set('data', 'dset5');
model.result('pg4').run;
model.result('pg4').feature('arwl3').feature('def1').set('expr', {'u' 'v-5e-3'});
model.result('pg4').run;
model.result('pg4').run;

model.title('Design Optimization of a Beam');

model.description('The mass of an aluminum beam is minimized subject to a displacement constraint and a distributed load. The problem is solved using parameter- shape- and topology optimization.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('beam_optimization.mph');

model.modelNode.label('Components');

out = model;
