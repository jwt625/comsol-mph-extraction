function out = model
%
% elastohydrodynamic_interaction.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Thin-Film_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tff', 'ThinFilmFlowShell', 'geom1');
model.physics('tff').model('comp1');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/tff', true);
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.param.set('a', '0.02[m]');
model.param.descr('a', 'Sphere radius');
model.param.set('extent', 'a');
model.param.descr('extent', 'Extent of lubricated area');
model.param.set('Force', '1.5[N]');
model.param.descr('Force', 'Applied force');
model.param.set('b0', 'a/10');
model.param.descr('b0', 'Initial film height');
model.param.set('visc_mat2', '0.8[Pa*s]');
model.param.descr('visc_mat2', 'Lubricant viscosity');
model.param.set('density_mat2', '860[kg/m^3]');
model.param.descr('density_mat2', 'Lubricant density');
model.param.set('timescale', '6*pi*visc_mat2*a^2/Force');
model.param.descr('timescale', 'Time scale');
model.param.set('nu_steel', '0.28');
model.param.descr('nu_steel', 'Poisson''s ratio');
model.param.set('E_steel', '205e9[Pa]');
model.param.descr('E_steel', 'Young''s modulus');
model.param.set('dens_steel', '7850[kg/m^3]');
model.param.descr('dens_steel', 'Density');
model.param.set('E_eqv', 'E_steel/(1-nu_steel^2)');
model.param.descr('E_eqv', 'Equivalent Young''s modulus');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'3*a' '3*a' '6*a'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-6*a'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('ca1', 'CircularArc');
model.geom('geom1').feature('wp1').geom.feature('ca1').set('specify', 'endsr');
model.geom('geom1').feature('wp1').geom.feature('ca1').set('point1', {'extent' '0'});
model.geom('geom1').feature('wp1').geom.feature('ca1').set('point2', {'0' 'extent'});
model.geom('geom1').feature('wp1').geom.feature('ca1').set('r', 'extent');

model.view('view1').set('locked', true);
model.view('view1').camera.setIndex('position', -0.56, 0);
model.view('view1').camera.setIndex('position', -0.75, 1);
model.view('view1').camera.set('position', [-0.56 -0.75 1.9]);
model.view('view1').camera.set('zoomanglefull', 6);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Lubricant');
model.selection('sel1').geom(2);
model.selection('sel1').set([4]);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('sel1');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('forcetot', '4*intop1(pfilm)');
model.variable('var1').descr('forcetot', 'Net force in lubricant');
model.variable('var1').set('r', 'sqrt(x^2+y^2)');
model.variable('var1').descr('r', 'Radial distance');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'E_eqv'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nu_steel'});
model.material('mat1').propertyGroup('def').set('density', {'dens_steel'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('sel1');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', {'visc_mat2'});
model.material('mat2').propertyGroup('def').set('density', {'density_mat2'});

model.physics('tff').selection.named('sel1');
model.physics('tff').feature('ffp1').set('hw1', 'b+r^2/(2*a)');
model.physics('tff').feature('ffp1').set('uw_src', 'root.comp1.u');
model.physics('tff').create('sym1', 'SymmetryFluid', 1);
model.physics('tff').feature('sym1').selection.set([4 5]);
model.physics('tff').create('ge1', 'GlobalEquations', -1);
model.physics('tff').feature('ge1').setIndex('name', 'b', 0, 0);
model.physics('tff').feature('ge1').setIndex('equation', 'Force-forcetot', 0, 0);
model.physics('tff').feature('ge1').setIndex('initialValueU', 'b0', 0, 0);
model.physics('tff').feature('ge1').setIndex('initialValueUt', 'b0/timescale', 0, 0);
model.physics('tff').feature('ge1').setIndex('description', 'Change in film height', 0, 0);
model.physics('tff').feature('ge1').set('DependentVariableQuantity', 'length');
model.physics('tff').feature('ge1').set('SourceTermQuantity', 'force');
model.physics('tff').create('ge2', 'GlobalEquations', -1);
model.physics('tff').feature('ge2').setIndex('name', 'k', 0, 0);
model.physics('tff').feature('ge2').setIndex('equation', 'timescale*kt+k/(1-2*a*k/(extent^2+2*a*k)-extent^2*(2*a*k)/(extent^2+2*a*k)^2)', 0, 0);
model.physics('tff').feature('ge2').setIndex('initialValueU', 'b0', 0, 0);
model.physics('tff').feature('ge2').setIndex('initialValueUt', 'b0/timescale', 0, 0);
model.physics('tff').feature('ge2').setIndex('description', 'Analytical change in film height', 0, 0);
model.physics('tff').feature('ge2').set('DependentVariableQuantity', 'length');
model.physics('tff').feature('ge2').set('SourceTermQuantity', 'length');

model.variable('var1').set('analytical_p', '-6*visc_mat2*kt*(2*a^3/(2*a*k+r^2)^2-2*a^3/(2*a*k+extent^2)^2)');
model.variable('var1').descr('analytical_p', 'Analytical pressure');

model.physics('solid').create('bndl1', 'BoundaryLoad', 2);
model.physics('solid').feature('bndl1').selection.named('sel1');
model.physics('solid').feature('bndl1').set('FperArea_src', 'root.comp1.tff.fwallx');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([3]);
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.set([1 2]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('sel1');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([2]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', '1.92e-4');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgrad', 1.15);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,2.0e-4,0.006)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '0.0001');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.14696938456699069');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2.0e-4,0.006)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_u'});
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Solid Mechanics');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_pfilm' 'comp1_ODE1' 'comp1_ODE2'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, pressure (tff)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Pressure');
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('t1').feature('i1').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobal', '1e-5');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Fluid Pressure (tff)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 31, 0);
model.result('pg1').set('defaultPlotID', 'ThinFilmFlowShell/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 31, 0);
model.result('pg2').set('defaultPlotID', 'stress');
model.result('pg2').label('Stress (solid)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', {'solid.misesGp'});
model.result('pg2').feature('vol1').set('threshold', 'manual');
model.result('pg2').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg2').feature('vol1').set('colortable', 'Rainbow');
model.result('pg2').feature('vol1').set('colortabletrans', 'none');
model.result('pg2').feature('vol1').set('colorscalemode', 'linear');
model.result('pg2').feature('vol1').set('resolution', 'custom');
model.result('pg2').feature('vol1').set('refine', 2);
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').create('def', 'Deform');
model.result('pg2').feature('vol1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('vol1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').selection.named('sel1');
model.result.dataset.create('sec1', 'Sector2D');
model.result.dataset('sec1').set('sectors', 4);
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Fluid Pressure, 2D');
model.result('pg3').set('data', 'sec1');
model.result('pg3').set('legendpos', 'bottom');
model.result('pg3').set('axisactive', true);
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('number', 8);
model.result('pg3').feature('con1').set('contourtype', 'filled');
model.result('pg3').feature('con1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg3').feature('con1').set('colortabletrans', 'reverse');
model.result('pg3').feature('con1').create('hght1', 'Height');
model.result('pg3').run;
model.result('pg3').feature('con1').feature('hght1').set('heightdata', 'expr');
model.result('pg3').feature('con1').feature('hght1').set('expr', 'tff.h');
model.result('pg3').feature('con1').feature('hght1').set('scaleactive', true);
model.result('pg3').feature('con1').feature('hght1').set('scale', 1);
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('vol1').feature('def').active(false);
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([2]);
model.result('pg4').feature('ptgr1').set('descractive', true);
model.result('pg4').feature('ptgr1').set('descr', 'Calculated maximum pressure');
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('autopoint', false);
model.result('pg4').feature('ptgr1').set('autodescr', true);
model.result('pg4').run;
model.result('pg4').create('ptgr2', 'PointGraph');
model.result('pg4').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr2').set('linewidth', 'preference');
model.result('pg4').feature('ptgr2').selection.set([2]);
model.result('pg4').feature('ptgr2').set('expr', 'analytical_p');
model.result('pg4').feature('ptgr2').set('linestyle', 'none');
model.result('pg4').feature('ptgr2').set('linecolor', 'blue');
model.result('pg4').feature('ptgr2').set('linemarker', 'asterisk');
model.result('pg4').feature('ptgr2').set('markerpos', 'interp');
model.result('pg4').feature('ptgr2').set('markers', 20);
model.result('pg4').feature('ptgr2').set('legend', true);
model.result('pg4').feature('ptgr2').set('autopoint', false);
model.result('pg4').feature('ptgr2').set('autodescr', true);
model.result('pg4').run;
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'b', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Change in film height', 0);
model.result('pg4').feature('glob1').set('linecolor', 'magenta');
model.result('pg4').run;
model.result('pg4').create('glob2', 'Global');
model.result('pg4').feature('glob2').set('markerpos', 'datapoints');
model.result('pg4').feature('glob2').set('linewidth', 'preference');
model.result('pg4').feature('glob2').setIndex('expr', 'k', 0);
model.result('pg4').feature('glob2').setIndex('unit', 'mm', 0);
model.result('pg4').feature('glob2').setIndex('descr', 'Analytical change in film height', 0);
model.result('pg4').feature('glob2').set('linestyle', 'none');
model.result('pg4').feature('glob2').set('linecolor', 'magenta');
model.result('pg4').feature('glob2').set('linemarker', 'asterisk');
model.result('pg4').feature('glob2').set('markerpos', 'interp');
model.result('pg4').feature('glob2').set('markers', 20);
model.result('pg4').run;
model.result('pg4').label('Maximum pressure and change in film height');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('twoyaxes', true);
model.result('pg4').setIndex('plotonsecyaxis', true, 2, 1);
model.result('pg4').setIndex('plotonsecyaxis', true, 3, 1);
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Pressure (Pa)');
model.result('pg4').set('yseclabelactive', true);
model.result('pg4').set('legendpos', 'uppermiddle');
model.result('pg4').run;

model.title('Transient Elastohydrodynamic Squeeze-Film Interaction');

model.description('This benchmark computes the transient pressure distribution and film height in a squeeze-film bearing for lubrication in a nonconformal conjunction of a solid sphere and an elastic wall separated by a lubricant film. The model solves the benchmark case of hydrodynamic interaction between a solid sphere and a wall separated by a lubricant film, and extends the benchmark case to include elastic deformation and stresses on the contacting wall. The model setup involves a solid sphere being pushed by an external force toward a solid plane wall. The lubricant layer gets squeezed by the approaching ball leading to a rise in the lubricant pressure. The calculated maximum lubricant pressure and change in film height as functions of time are compared with analytical solutions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('elastohydrodynamic_interaction.mph');

model.modelNode.label('Components');

out = model;
