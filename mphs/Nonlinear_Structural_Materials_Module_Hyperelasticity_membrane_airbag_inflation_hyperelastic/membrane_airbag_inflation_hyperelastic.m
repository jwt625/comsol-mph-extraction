function out = model
%
% membrane_airbag_inflation_hyperelastic.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Hyperelasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbrn', 'StructuralMembrane', 'geom1');
model.physics('mbrn').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mbrn', true);

model.param.label('Model Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('para', '0', 'Parameter');
model.param.set('th', '1[mm]', 'Thickness');
model.param.set('Ld', '1.2[m]', 'Diagonal length of noninflated airbag');
model.param.set('L', 'Ld/sqrt(2)', 'Length parameter');
model.param.set('EE', '588[MPa]', 'Young''s modulus');
model.param.set('Nu', '0.4', 'Poisson''s ratio');
model.param.set('Pmax', '5[kPa]', 'Maximum air pressure');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'F');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 100, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', 1, 1, 1);
model.func('int1').setIndex('fununit', 'N/m', 0);
model.func('int1').setIndex('argunit', 1, 0);

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('wmax_ref', '22.45[cm]');
model.variable('var1').descr('wmax_ref', 'Transverse displacement at midpoint, reference');
model.variable('var1').set('u1max_ref', '3.07[cm]');
model.variable('var1').descr('u1max_ref', 'Lateral displacement at corner point, reference');
model.variable('var1').set('u2max_ref', '11.58[cm]');
model.variable('var1').descr('u2max_ref', 'Lateral displacement at midpoint of side edge, reference');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 'L/2');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', {'L/2' '0'});
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');

model.physics('mbrn').prop('ShapeProperty').set('order_displacement', 1);
model.physics('mbrn').create('hmm1', 'HyperelasticModel', 2);
model.physics('mbrn').feature('hmm1').selection.all;
model.physics('mbrn').feature('hmm1').set('IsotropicOption', 'Enu');
model.physics('mbrn').feature('hmm1').create('wr1', 'Wrinkling', 2);
model.physics('mbrn').feature('hmm1').feature('wr1').set('termination', 'steporresi');
model.physics('mbrn').feature('to1').set('d', 'th');
model.physics('mbrn').create('sym1', 'Symmetry', 1);
model.physics('mbrn').feature('sym1').selection.set([1 3]);
model.physics('mbrn').create('disp1', 'Displacement1', 1);
model.physics('mbrn').feature('disp1').selection.set([2 4]);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('mbrn').create('fl1', 'FaceLoad', 2);
model.physics('mbrn').feature('fl1').selection.set([1]);
model.physics('mbrn').feature('fl1').set('LoadType', 'FollowerPressure');
model.physics('mbrn').feature('fl1').set('FollowerPressure', '-Pmax*para');
model.physics('mbrn').create('el1', 'EdgeLoad', 1);
model.physics('mbrn').feature('el1').selection.set([2 4]);
model.physics('mbrn').feature('el1').set('coordinateSystem', 'LocalEdgeSystem');
model.physics('mbrn').feature('el1').set('FperLength', {'0' '-F(para)' '0'});
model.physics('mbrn').create('spf1', 'SpringFoundation2', 2);
model.physics('mbrn').feature('spf1').selection.all;
model.physics('mbrn').feature('spf1').set('kPerArea', {'0' '0' '0' '0' '0' '0' '0' '0' '1e-3[N/m^3]'});

model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'EE'});
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup('def').set('density', {'0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 25);
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('conv1').set('splitmethod', 'center');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.001,1)', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.5999999999999998');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pmaxstep', 0.001);
model.sol('sol1').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').runAll;

model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'xz');
model.result.dataset('mir1').set('quicky', '0.5*L');
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'mir1');
model.result.dataset('mir2').set('quickplane', 'yz');
model.result.dataset('mir2').set('quickx', '0.5*L');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1001, 0);
model.result('pg1').set('defaultPlotID', 'displacement');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').label('Displacement (mbrn)');
model.result('pg1').set('showlegends', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'mbrn.disp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').label('Displacement (mbrn)');
model.result('pg1').run;
model.result('pg1').label('Transverse Displacement');
model.result('pg1').set('data', 'mir2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'w');
model.result('pg1').feature('surf1').set('unit', 'cm');
model.result('pg1').feature('surf1').set('threshold', 'none');
model.result('pg1').run;
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('First Principal Stress');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'mbrn.sp1Gp');
model.result('pg2').feature('surf1').set('descr', 'First principal stress');
model.result('pg2').feature('surf1').set('unit', 'MPa');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').run;
model.result('pg2').set('view', 'new');
model.result('pg2').run;

model.view('view4').set('showgrid', false);

model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Second Principal Stress');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'mbrn.sp2Gp');
model.result('pg3').feature('surf1').set('descr', 'Second principal stress');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Wrinkled Region');
model.result('pg4').set('showlegendsmaxmin', false);
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'mbrn.iswrinkled');
model.result('pg4').feature('surf1').set('descr', 'Is wrinkled');
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('smooth', 'none');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Point Displacements');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([2]);
model.result('pg5').feature('ptgr1').set('expr', 'w');
model.result('pg5').feature('ptgr1').set('unit', 'cm');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'Pmax*para');
model.result('pg5').feature('ptgr1').set('xdataunit', 'kPa');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Transverse displacement at midpoint', 0);
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').selection.set([4]);
model.result('pg5').feature('ptgr2').set('expr', '-u');
model.result('pg5').feature('ptgr2').setIndex('legends', 'Lateral displacement at corner point', 0);
model.result('pg5').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg5').run;
model.result('pg5').feature('ptgr3').selection.set([3]);
model.result('pg5').feature('ptgr3').setIndex('legends', 'Lateral displacement at midpoint of side edge', 0);
model.result('pg5').run;
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('data', 'dset1');
model.result('pg5').feature('glob1').setIndex('looplevelinput', 'last', 0);
model.result('pg5').feature('glob1').setIndex('expr', 'wmax_ref', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'cm', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Transverse displacement at midpoint, reference', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'Pmax*para');
model.result('pg5').feature('glob1').set('xdataunit', 'kPa');
model.result('pg5').feature('glob1').set('linecolor', 'magenta');
model.result('pg5').feature('glob1').set('linemarker', 'square');
model.result('pg5').feature('glob1').set('markerpos', 'interp');
model.result('pg5').feature('glob1').set('markers', 12);
model.result('pg5').feature('glob1').set('legendmethod', 'manual');
model.result('pg5').feature('glob1').setIndex('legends', 'Reference values at last step', 0);
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob2').setIndex('expr', 'u1max_ref', 0);
model.result('pg5').feature('glob2').setIndex('unit', 'cm', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'Lateral displacement at corner point, reference', 0);
model.result('pg5').feature('glob2').set('legend', false);
model.result('pg5').feature.duplicate('glob3', 'glob2');
model.result('pg5').run;
model.result('pg5').feature('glob3').setIndex('expr', 'u2max_ref', 0);
model.result('pg5').feature('glob3').setIndex('unit', 'cm', 0);
model.result('pg5').feature('glob3').setIndex('descr', 'Total displacement at midpoint of side edge, reference', 0);
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Point displacements');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Inflation pressure (kPa)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Displacement (cm)');
model.result('pg5').set('axislimits', true);
model.result('pg5').set('ymax', 30);
model.result('pg5').run;
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Point Stress');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Inflation pressure (kPa)');
model.result('pg6').set('legendpos', 'upperleft');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').selection.set([2]);
model.result('pg6').feature('ptgr1').set('expr', 'mbrn.sp1');
model.result('pg6').feature('ptgr1').set('unit', 'kN/cm^2');
model.result('pg6').feature('ptgr1').set('xdata', 'expr');
model.result('pg6').feature('ptgr1').set('xdataexpr', 'Pmax*para');
model.result('pg6').feature('ptgr1').set('xdataunit', 'kPa');
model.result('pg6').feature('ptgr1').set('legend', true);
model.result('pg6').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg6').feature('ptgr1').setIndex('legends', 'First principal stress at midpoint', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg1').run;
model.result('pg4').run;

model.title('Inflation of a Square Hyperelastic Airbag');

model.description(['A square airbag made of a neo-Hookean hyperelastic material is inflated using a constant air pressure. In some regions of the airbag the material wrinkles, as negative principal stresses develop.' newline  newline 'In this example, the wrinkling membrane model within the tension field theory gives a correct description of the stress distribution and wrinkling pattern in the inflated membrane.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('membrane_airbag_inflation_hyperelastic.mph');

model.modelNode.label('Components');

out = model;
