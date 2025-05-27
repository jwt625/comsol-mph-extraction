function out = model
%
% concrete_beam_cdpm.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Concrete');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('truss', 'Truss', 'geom1');
model.physics('truss').model('comp1');
model.physics('truss').field('displacement').field('u');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/truss', true);

model.param.set('disp', '0[mm]');
model.param.set('meshSize', '20[mm]');
model.param.create('par2');
model.param('par2').label('Geometry Parameters');
model.param('par2').set('length1', '250[mm]');
model.param('par2').set('length2', '1750[mm]');
model.param('par2').set('length3', '500[mm]');
model.param('par2').set('heigth', '300[mm]');
model.param('par2').set('width', '200[mm]');
model.param('par2').set('bcWidth', '150[mm]');
model.param('par2').set('rebarPosition', '50[mm]');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'length1+length2+length3/2' '1'});
model.geom('geom1').feature('r1').setIndex('size', 'heigth', 1);
model.geom('geom1').feature('r1').setIndex('layer', 'length1-bcWidth/2', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'bcWidth', 1);
model.geom('geom1').feature('r1').setIndex('layer', 'length2-bcWidth', 2);
model.geom('geom1').feature('r1').setIndex('layer', 'bcWidth', 3);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'rebarPosition', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'length1+length2+length3/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'rebarPosition', 1, 1);
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');
model.geom('geom1').create('mce1', 'MeshControlEdges');
model.geom('geom1').feature('mce1').selection('input').set('fin', [4 7 10 13]);
model.geom('geom1').feature('mce1').set('includevtx', false);
model.geom('geom1').run('mce1');
model.geom('geom1').create('mcv1', 'MeshControlVertices');
model.geom('geom1').feature('mcv1').selection('input').set('mce1', [4 6 7 9]);
model.geom('geom1').run('mcv1');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 'width');
model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.physics('solid').feature('lemm1').set('reducedIntegration', true);
model.physics('solid').feature('lemm1').create('cm1', 'Concrete', 2);
model.physics('solid').feature('lemm1').feature('cm1').set('materialModel', 'coupledDamagePlasticity');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([8]);
model.physics('solid').create('rig1', 'RigidConnector', 1);
model.physics('solid').feature('rig1').selection.set([4]);
model.physics('solid').feature('rig1').setIndex('Direction', true, 1);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([8]);

model.physics('solid').create('ge1', 'GlobalEquations', -1);
model.physics('solid').feature('ge1').setIndex('name', 'load', 0, 0);
model.physics('solid').feature('ge1').setIndex('equation', 'intop1(v)+disp', 0, 0);
model.physics('solid').feature('ge1').set('DependentVariableQuantity', 'force');
model.physics('solid').feature('ge1').set('SourceTermQuantity', 'displacement');
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([6]);
model.physics('solid').feature('bndl1').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl1').set('Ftot', {'0' '-load/2' '0'});
model.physics('solid').create('bndl2', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl2').selection.set([3 6 7]);
model.physics('solid').feature('bndl2').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl2').set('Ftot', {'0' '-load/2' '0'});
model.physics('truss').selection.set([9]);
model.physics('truss').feature('emm1').create('plsty1', 'Plasticity', 1);
model.physics('truss').feature('csd1').set('area', 'heigth*width*0.4[%]');
model.physics('truss').create('sym1', 'SymmetrySolid20', 0);
model.physics('truss').feature('sym1').selection.set([10]);

model.multiphysics.create('ere1', 'EmbeddedReinforcement', 'geom1', -1);
model.multiphysics('ere1').selection('dstEdgSel').set([9]);
model.multiphysics('ere1').set('connectionType', 'kPerArea');
model.multiphysics('ere1').set('kaPerArea', '((1e-1*ere1.Eequ)*ere1.perimeter)/(h^2)');
model.multiphysics('ere1').set('ktPerArea', '((1e1*ere1.Eequ)*ere1.perimeter)/(h^2)');
model.multiphysics('ere1').set('bondSlip', 'friction');
model.multiphysics('ere1').set('cohesion', '1[MPa]');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('argunit', 'mm');
model.func('pw1').set('fununit', '1');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 0.3, 0, 1);
model.func('pw1').setIndex('pieces', 'max((x/0.3),eps)^0.4', 0, 2);
model.func('pw1').setIndex('pieces', 0.3, 1, 0);
model.func('pw1').setIndex('pieces', 2, 1, 1);
model.func('pw1').setIndex('pieces', 1, 1, 2);
model.func('pw1').setIndex('pieces', 2, 2, 0);
model.func('pw1').setIndex('pieces', 6, 2, 1);
model.func('pw1').setIndex('pieces', '1-(1-0.15)*(x-2)/(6-2)', 2, 2);

model.multiphysics('ere1').set('hardening', 'userDefined');
model.multiphysics('ere1').set('hardeningFunc', '5[MPa]*pw1(ere1.upe)');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'25[GPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.2'});
model.material('mat1').propertyGroup('def').set('density', {'0'});
model.material('mat1').propertyGroup.create('YieldStressParameters', 'Yield_stress_parameters');
model.material('mat1').propertyGroup('YieldStressParameters').set('sigmaut', {'2[MPa]'});
model.material('mat1').propertyGroup('YieldStressParameters').set('sigmauc', {'30[MPa]'});
model.material('mat1').propertyGroup.create('FractureParameters', 'Fracture_parameters');
model.material('mat1').propertyGroup('FractureParameters').set('Gft', {'220[J/m^2]'});

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', 'if(x>=length1+length2+length3/2-1.05*meshSize/2,1/2,1)');
model.func('an1').set('fununit', '1');
model.func('an1').setIndex('argunit', 'm', 0);

model.material('mat1').propertyGroup('FractureParameters').set('Gft', {'220[J/m^2]*an1(centroid(X))'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.set([9]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'208[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat2').propertyGroup('def').set('density', {'0'});
model.material('mat2').propertyGroup.create('ElastoplasticModel', 'Elastoplastic_material_model');
model.material('mat2').propertyGroup('ElastoplasticModel').set('sigmags', {'500[MPa]'});
model.material('mat2').propertyGroup('ElastoplasticModel').set('Et', {'1[GPa]'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([9]);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'meshSize');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'bcWidth', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'bcWidth', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,1,65)', 0);
model.study('std1').feature('stat').setIndex('punit', 'mm', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_wZ').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_disp').set('scaleval', '0.022699118925632335');
model.sol('sol1').feature('v1').feature('comp1_solid_rig_rot').set('scaleval', '0.01');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*2.2699118925632336');
model.sol('sol1').feature('v1').feature('comp1_solid_wZ').set('scaleval', '1e-2');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 12);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 12);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pinitstep', '0.5/1000');
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '1e-8');
model.sol('sol1').feature('s1').feature('p1').set('pmaxstep', '2/1000');
model.sol('sol1').feature('s1').feature('p1').set('ponerror', 'skip');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', '1.0e-1');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'load');
model.probe('var1').set('unit', 'kN');
model.probe('var1').genResult('none');

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'truss.misesGp'});
model.result('pg3').feature('line1').set('threshold', 'manual');
model.result('pg3').feature('line1').set('thresholdvalue', 0.2);
model.result('pg3').feature('line1').set('colortable', 'Rainbow');
model.result('pg3').feature('line1').set('colortabletrans', 'none');
model.result('pg3').feature('line1').set('colorscalemode', 'linear');
model.result('pg3').label('Stress (truss)');
model.result('pg3').feature('line1').set('colortable', 'Rainbow');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'truss.re');
model.result('pg3').feature('line1').set('resolution', 'extrafine');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg3').feature('line1').set('tuberadiusscale', 1);
model.result('pg3').feature('line1').set('tubeendcaps', false);
model.result('pg3').feature('line1').create('def', 'Deform');
model.result('pg3').feature('line1').feature('def').set('expr', {'u' 'v'});
model.result('pg3').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Damage (solid)');
model.result('pg4').set('defaultPlotID', 'damage');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid.dmgGp'});
model.result('pg4').feature('surf1').set('inheritplot', 'none');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortabletype', 'discrete');
model.result('pg4').feature('surf1').set('bandcount', 11);
model.result('pg4').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg4').feature('surf1').set('smooth', 'none');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Damage');
model.result('pg4').label('Damage (solid)');
model.result('pg4').run;

model.study('std1').feature('stat').set('plot', true);
model.study('std1').feature('stat').set('plotgroup', 'pg4');
model.study('std1').feature('stat').set('probefreq', 'psteps');

model.probe('var1').genResult('none');

model.sol('sol1').runAll;

model.result('pg2').run;
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Vertical displacement (mm)');
model.result('pg1').set('showlegends', false);
model.result('pg1').set('window', 'window2');
model.result('pg1').set('windowtitle', 'Probe Plot 2');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid.sdGpxx');
model.result('pg2').feature('surf1').set('descr', 'Stress tensor, damaged, xx-component');
model.result('pg2').feature('surf1').set('unit', 'MPa');
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').run;
model.result('pg4').create('arwl1', 'ArrowLine');
model.result('pg4').feature('arwl1').set('expr', {'solid.F_Ax' 'solid.F_Ay'});
model.result('pg4').feature('arwl1').set('descr', 'Load (spatial frame)');
model.result('pg4').feature('arwl1').set('titletype', 'none');
model.result('pg4').feature('arwl1').set('placement', 'gausspoints');
model.result('pg4').feature('arwl1').set('arrowbase', 'head');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Crack Width (solid)');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', 'solid.gpeval(solid.lemm1.cm1.wdmgt)');
model.result('pg5').feature('surf1').set('unit', 'mm');
model.result('pg5').feature('surf1').set('descr', 'Crack Width');
model.result('pg5').feature('surf1').set('rangecoloractive', true);
model.result('pg5').feature('surf1').set('rangecolormax', 1);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Plastic Strain (truss)');
model.result('pg6').setIndex('looplevelinput', 'last', 0);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').selection.set([9]);
model.result('pg6').feature('lngr1').set('expr', 'truss.epnGp');
model.result('pg6').feature('lngr1').set('descr', 'Plastic axial strain');
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').set('titletype', 'none');
model.result('pg7').label('Slip');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Slip (mm)');
model.result('pg7').run;
model.result('pg7').feature('lngr1').set('expr', 'gpeval(2,ere1.un)');
model.result('pg7').feature('lngr1').set('unit', 'mm');
model.result('pg7').run;
model.result('pg5').run;

model.title(['Failure of a Concrete Beam Using Coupled Damage' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Plasticity']);

model.description('Failure of reinforced concrete structures involves advanced material behavior and interaction between materials. Here, it is demonstrated how to model various stages of the failure of a reinforced concrete beam by including a coupled damage-plasticity material model for the concrete, metal plasticity for the rebars, and a nonlinear bond-slip law for the interaction between concrete and the rebar.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('concrete_beam_cdpm.mph');

model.modelNode.label('Components');

out = model;
