function out = model
%
% flexible_footing.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Soil');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('v_prescr', '0[m]');
model.param.descr('v_prescr', 'Prescribed displacement');
model.param.set('W', '7.32[m]');
model.param.descr('W', 'Width');
model.param.set('H', '3.66[m]');
model.param.descr('H', 'Height');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W*1.1' 'H'});
model.geom('geom1').feature('r1').set('pos', {'-W*0.1' '0'});
model.geom('geom1').feature('r1').setIndex('layer', 'W*0.1', 0);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layerleft', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'W-1.57[m]', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'H', 1);
model.geom('geom1').run('fin');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.set([1]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([7]);

model.physics('solid').feature('lemm1').create('soil1', 'SoilModel', 2);
model.physics('solid').feature('lemm1').feature('soil1').set('MatchtoMC', true);
model.physics('solid').feature('lemm1').create('soil2', 'SoilModel', 2);
model.physics('solid').feature('lemm1').feature('soil2').set('YieldCriterion', 'MohrCoulomb');
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([2 5]);
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([8]);
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([1]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([7]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' 'footing_pressure' '0'});
model.physics('solid').create('ge1', 'GlobalEquations', -1);
model.physics('solid').feature('ge1').setIndex('name', 'footing_pressure', 0, 0);
model.physics('solid').feature('ge1').setIndex('equation', 'intop1(v) - v_prescr', 0, 0);
model.physics('solid').feature('ge1').set('DependentVariableQuantity', 'pressure');
model.physics('solid').feature('ge1').set('SourceTermQuantity', 'displacement');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'207[MPa]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'69[kPa]'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'20[deg]'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([2]);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').run;

model.study('std1').label(['Study: Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager']);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/lemm1/soil2'});
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'v_prescr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'v_prescr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0, -5e-4, -32e-3)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 65, 0);
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
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 65, 0);
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result('pg2').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg2').feature('surf1').set('colortabletype', 'discrete');
model.result('pg2').feature('surf1').set('bandcount', 11);
model.result('pg2').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg2').label('Equivalent Plastic Strain (solid)');
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label(['Study: Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb ']);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'solid/lemm1/soil1'});
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'v_prescr', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'v_prescr', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0, -5e-4, -24.5e-3)', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').set('stol', '1e-4');
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 50, 0);
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid) 1');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg3').feature('surf1').set('threshold', 'manual');
model.result('pg3').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').create('def', 'Deform');
model.result('pg3').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg3').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 50, 0);
model.result('pg4').label('Equivalent Plastic Strain (solid) 1');
model.result('pg4').set('defaultPlotID', 'equivalentPlasticStrain');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'solid.epeGp'});
model.result('pg4').feature('surf1').set('inheritplot', 'none');
model.result('pg4').feature('surf1').set('resolution', 'normal');
model.result('pg4').feature('surf1').set('colortabletype', 'discrete');
model.result('pg4').feature('surf1').set('bandcount', 11);
model.result('pg4').feature('surf1').set('colortable', 'AuroraAustralisDark');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Equivalent plastic strain');
model.result('pg4').label('Equivalent Plastic Strain (solid) 1');
model.result('pg4').run;
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([2]);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([2]);
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').setIndex('genpoints', 'W', 0, 0);
model.result.dataset('mir1').setIndex('genpoints', 'W', 1, 0);
model.result.dataset('mir1').set('removesymelem', true);
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'dset2');
model.result('pg1').run;
model.result('pg1').label(['Stress, Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager']);
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'kPa');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 10);
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'solid.F_Ax' 'solid.F_Ay'});
model.result('pg1').feature('arwl1').set('descr', 'Load (spatial frame)');
model.result('pg1').feature('arwl1').set('titletype', 'none');
model.result('pg1').feature('arwl1').set('arrowbase', 'head');
model.result('pg1').feature('arwl1').set('scaleactive', true);
model.result('pg1').feature('arwl1').set('scale', '5E-7');
model.result('pg1').feature('arwl1').set('inheritplot', 'surf1');
model.result('pg1').feature('arwl1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').label(['Stress, Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb']);
model.result('pg3').set('data', 'mir2');
model.result('pg3').set('edges', false);
model.result('pg3').run;
model.result('pg3').feature('surf1').set('unit', 'kPa');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('def').set('scale', 10);
model.result('pg3').run;
model.result('pg3').create('arwl1', 'ArrowLine');
model.result('pg3').feature('arwl1').set('expr', {'solid.F_Ax' 'solid.F_Ay'});
model.result('pg3').feature('arwl1').set('descr', 'Load (spatial frame)');
model.result('pg3').feature('arwl1').set('titletype', 'none');
model.result('pg3').feature('arwl1').set('arrowbase', 'head');
model.result('pg3').feature('arwl1').set('scaleactive', true);
model.result('pg3').feature('arwl1').set('scale', '5E-7');
model.result('pg3').feature('arwl1').set('inheritplot', 'surf1');
model.result('pg3').feature('arwl1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label(['Plastic Region, Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb']);
model.result('pg4').set('data', 'mir2');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg4').feature('surf1').set('bandcount', 2);
model.result('pg4').feature('surf1').set('resolution', 'custom');
model.result('pg4').feature('surf1').set('refine', 2);
model.result('pg2').run;
model.result('pg2').label(['Plastic Region, Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager']);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'solid.epeGp>0');
model.result('pg2').feature('surf1').set('bandcount', 2);
model.result('pg2').feature('surf1').set('resolution', 'custom');
model.result('pg2').feature('surf1').set('refine', 2);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Footing Pressure vs. Displacement');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').set('data', 'dset1');
model.result('pg5').feature('ptgr1').selection.set([7]);
model.result('pg5').feature('ptgr1').set('expr', 'abs(footing_pressure)');
model.result('pg5').feature('ptgr1').set('unit', 'kPa');
model.result('pg5').feature('ptgr1').set('descractive', true);
model.result('pg5').feature('ptgr1').set('descr', 'Footing pressure');
model.result('pg5').feature('ptgr1').set('xdata', 'expr');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'abs(v)');
model.result('pg5').feature('ptgr1').set('xdatadescractive', true);
model.result('pg5').feature('ptgr1').set('xdatadescr', 'Vertical displacement');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', ['Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager'], 0);
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').set('data', 'dset2');
model.result('pg5').feature('ptgr2').set('titletype', 'none');
model.result('pg5').feature('ptgr2').setIndex('legends', ['Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb'], 0);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg2').run;
model.result('pg2').set('data', 'mir1');
model.result('pg1').run;
model.result('pg2').run;
model.result.duplicate('pg6', 'pg2');
model.result('pg6').run;
model.result('pg6').set('data', 'dset1');
model.result('pg6').selection.geom('geom1', 2);
model.result('pg6').selection.geom('geom1', 2);
model.result('pg6').selection.set([2]);
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('plotarrayenable', true);
model.result('pg6').set('arrayshape', 'square');
model.result('pg6').set('order', 'columnmajor');
model.result('pg6').set('relrowpadding', 0.15);
model.result('pg6').set('relcolumnpadding', 0.1);
model.result('pg6').feature('surf1').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('data', 'dset1');
model.result('pg6').feature('surf1').setIndex('looplevel', 1, 0);
model.result('pg6').feature('surf1').set('manualindexing', true);
model.result('pg6').feature('surf1').set('rowindex', 2);
model.result('pg6').feature.duplicate('surf2', 'surf1');
model.result('pg6').feature('surf2').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf2').setIndex('looplevel', 10, 0);
model.result('pg6').feature('surf2').set('inheritplot', 'surf1');
model.result('pg6').feature('surf2').set('colindex', 1);
model.result('pg6').feature.duplicate('surf3', 'surf2');
model.result('pg6').feature('surf3').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf3').setIndex('looplevel', 19, 0);
model.result('pg6').feature('surf3').set('rowindex', 1);
model.result('pg6').feature('surf3').set('colindex', 0);
model.result('pg6').feature.duplicate('surf4', 'surf3');
model.result('pg6').feature('surf4').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf4').setIndex('looplevel', 28, 0);
model.result('pg6').feature('surf4').set('colindex', 1);
model.result('pg6').feature.duplicate('surf5', 'surf4');
model.result('pg6').feature('surf5').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf5').setIndex('looplevel', 37, 0);
model.result('pg6').feature('surf5').set('rowindex', 0);
model.result('pg6').feature('surf5').set('colindex', 0);
model.result('pg6').feature.duplicate('surf6', 'surf5');
model.result('pg6').feature('surf6').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf6').setIndex('looplevel', 65, 0);
model.result('pg6').feature('surf6').set('colindex', 1);
model.result('pg6').run;
model.result('pg6').create('ann1', 'Annotation');
model.result('pg6').feature('ann1').set('arraydim', '2');
model.result('pg6').feature('ann1').set('data', 'dset1');
model.result('pg6').feature('ann1').setIndex('looplevel', 1, 0);
model.result('pg6').feature('ann1').set('text', '$p_a = eval(abs(footing_pressure), MPa, 3) \ \textrm{MPa}$');
model.result('pg6').feature('ann1').set('latexmarkup', true);
model.result('pg6').feature('ann1').set('showpoint', false);
model.result('pg6').feature('ann1').set('manualindexing', true);
model.result('pg6').feature('ann1').set('rowindex', 2);
model.result('pg6').feature('ann1').set('applytodatasetedgesplotarr', false);
model.result('pg6').feature('ann1').create('trn1', 'Translation');
model.result('pg6').run;
model.result('pg6').feature('ann1').feature('trn1').set('trans', {'0' 'H*1.2'});
model.result('pg6').feature('ann1').feature('trn1').set('applytodatasetedges', false);
model.result('pg6').run;
model.result('pg6').feature('ann1').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature.duplicate('ann2', 'ann1');
model.result('pg6').feature('ann2').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('ann2').setIndex('looplevel', 10, 0);
model.result('pg6').feature('ann2').set('colindex', 1);
model.result('pg6').feature.duplicate('ann3', 'ann2');
model.result('pg6').feature('ann3').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('ann3').setIndex('looplevel', 19, 0);
model.result('pg6').feature('ann3').set('rowindex', 1);
model.result('pg6').feature('ann3').set('colindex', 0);
model.result('pg6').feature.duplicate('ann4', 'ann3');
model.result('pg6').feature('ann4').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('ann4').setIndex('looplevel', 28, 0);
model.result('pg6').feature('ann4').set('colindex', 1);
model.result('pg6').feature.duplicate('ann5', 'ann4');
model.result('pg6').feature('ann5').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('ann5').setIndex('looplevel', 37, 0);
model.result('pg6').feature('ann5').set('rowindex', 0);
model.result('pg6').feature('ann5').set('colindex', 0);
model.result('pg6').feature.duplicate('ann6', 'ann5');
model.result('pg6').feature('ann6').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('ann6').setIndex('looplevel', 65, 0);
model.result('pg6').feature('ann6').set('colindex', 1);
model.result('pg6').run;
model.result.remove('pg6');

model.title('Flexible and Smooth Strip Footing on a Stratum of Clay');

model.description(['A common verification problem for geotechnical problems is a shallow stratum layer of clay. In this example a vertical load is applied on the clay strata and the static response and the collapse load are studied. The clay is modeled as an elastic-perfectly plastic material and the Drucker' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Prager and Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb yield conditions under plane strain conditions are compared.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('flexible_footing.mph');

model.modelNode.label('Components');

out = model;
