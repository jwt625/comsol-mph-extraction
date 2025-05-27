function out = model
%
% magnetic_circuit_topology_optimization.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Optimization');

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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').insertFile('magnetic_circuit_topology_optimization_geom_sequence.mph', 'geom1');
model.geom('geom1').run('difsel1');

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Model Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('B0', '0.4[T]', 'Magnet remanent flux');
model.param('par2').set('N0', '100', 'Number of turns');
model.param('par2').set('BL_0', '7.5[Wb/m]', 'Objective BL');
model.param('par2').set('volfrac', '0.4', 'Objective density');
model.param('par2').set('mesh_size', '0.4[mm]', 'Mesh size in the design space');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat1').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat1').label('Soft Iron (With Losses)');
model.material('mat1').set('family', 'iron');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat1').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'663.146' '1';  ...
'1067.5' '1.1';  ...
'1705.23' '1.2';  ...
'2463.11' '1.3';  ...
'3841.67' '1.4';  ...
'5425.74' '1.5';  ...
'7957.75' '1.6';  ...
'12298.3' '1.7';  ...
'20462.8' '1.8';  ...
'32169.6' '1.9';  ...
'61213.4' '2';  ...
'111408' '2.1';  ...
'188487.757' '2.2';  ...
'267930.364' '2.3';  ...
'347507.836' '2.4'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat1').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat1').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat1').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat1').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat1').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat1').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat1').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat1').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
'663.146' '1.000000051691021';  ...
'1067.5' '1.4936495124126294';  ...
'1705.23' '1.9415328461315795';  ...
'2463.11' '2.257765669366018';  ...
'3841.67' '2.609980642431287';  ...
'5425.74' '2.8664452090837504';  ...
'7957.75' '3.1441438097176118';  ...
'12298.3' '3.448538051654125';  ...
'20462.8' '3.7816711973679054';  ...
'32169.6' '4.058345590113038';  ...
'61213.4' '4.420646552950275';  ...
'111408' '4.721274089545955';  ...
'188487.757' '4.972148140718701';  ...
'267930.364' '5.145510860855953';  ...
'347507.836' '5.245510861426532'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat1').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat1').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material.create('mat2', 'Common', '');
model.material('mat2').label('Generic Ferrite');
model.material('mat2').propertyGroup('def').set('electricconductivity', '');
model.material('mat2').propertyGroup('def').set('relpermittivity', '');
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent_flux_density');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', {'B0'});

model.func.create('an1', 'Analytic');
model.func('an1').label('Equivalent mur of mat1, Soft Iron (With Losses)');
model.func('an1').set('funcname', 'mur1');
model.func('an1').set('expr', 'sqrt(Bx^2+By^2+eps[T^2])/mat1.BHCurve.BH_inv(sqrt(Bx^2+By^2+eps[T^2]))/mu0_const');
model.func('an1').set('args', 'Bx, By');
model.func('an1').set('fununit', '1');
model.func('an1').setIndex('argunit', 'T', 0);
model.func('an1').setIndex('argunit', 'T', 1);
model.func('an1').setIndex('plotargs', 2, 0, 2);
model.func('an1').setIndex('plotargs', 2, 1, 2);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Area to Obtain the BL Factor');
model.cpl('intop1').set('opname', 'int_BL');
model.cpl('intop1').selection.named('geom1_r5_dom');
model.cpl('intop1').set('intorder', 30);
model.cpl('intop1').set('axisym', false);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Global Variables');
model.variable('var1').set('BL_integrand', '-mf.Br*N0*2*pi*r/(w_coil*h_coil)');
model.variable('var1').descr('BL_integrand', 'Integrand to obtain the BL factor');
model.variable('var1').set('coil_location_z', '(z>(dest(z)-h_coil/2))*(z<(dest(z)+h_coil/2))');
model.variable('var1').descr('coil_location_z', 'Logical condition to discern the position of the coil');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Point Variables');
model.variable('var2').selection.geom('geom1', 0);
model.variable('var2').selection.all;
model.variable('var2').set('BL_point', 'int_BL(BL_integrand*coil_location_z)');
model.variable('var2').descr('BL_point', 'BL Factor at Point');

model.probe.create('point1', 'Point');
model.probe('point1').model('comp1');
model.probe('point1').label('Point Probe - Objective 1');
model.probe('point1').set('probename', 'obj_1');
model.probe('point1').selection.named('geom1_pt2_pnt');
model.probe('point1').set('expr', 'BL_point');
model.probe.create('point2', 'Point');
model.probe('point2').model('comp1');
model.probe('point2').label('Point Probe - Objective 2');
model.probe('point2').set('probename', 'obj_2');
model.probe('point2').selection.named('geom1_arr1_pnt');
model.probe('point2').set('expr', '(BL_point-BL_0)^2');

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').selection.named('geom1_difsel1');
model.common('dtopo1').set('simpExponentType', 'Custom');
model.common('dtopo1').set('p_SIMP', '10');
model.common('dtopo1').set('thetaMinType', 'Custom');
model.common('dtopo1').set('theta_min', '0');
model.common('dtopo1').set('discretization', 'constant');
model.common('dtopo1').set('theta_0', 'volfrac');

model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').label('Topology Optimization');
model.material('matlnk1').selection.named('geom1_difsel1');
model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').label('Magnet');
model.material('matlnk2').selection.named('geom1_r4_dom');
model.material('matlnk2').set('link', 'mat2');

model.physics('mf').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').label('Topology Optimization');
model.physics('mf').feature('als1').selection.named('geom1_difsel1');
model.physics('mf').feature('als1').set('mur_mat', 'userdef');
model.physics('mf').feature('als1').set('mur', {'1+dtopo1.theta_p*(mur1(mf.Br,mf.Bz)-1)' '0' '0' '0' '1+dtopo1.theta_p*(mur1(mf.Br,mf.Bz)-1)' '0' '0' '0' '1+dtopo1.theta_p*(mur1(mf.Br,mf.Bz)-1)'});
model.physics('mf').create('als2', 'AmperesLawSolid', 2);
model.physics('mf').feature('als2').label('Magnet');
model.physics('mf').feature('als2').selection.named('geom1_r4_dom');
model.physics('mf').feature('als2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als2').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', 'mesh_size');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_difsel1');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'mesh_size');
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').label('Study 1 - Max BL at Rest Optimization');
model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').feature('topo').set('mmamaxiter', 20);
model.study('std1').feature('topo').set('optobj', {'comp1.obj_1'});
model.study('std1').feature('topo').set('descr', {'Point Probe - Objective 1'});
model.study('std1').feature('topo').set('objectivetype', 'maximization');
model.study('std1').feature('topo').set('objectivescaling', 'init');
model.study('std1').feature('topo').set('constraintExpression', {'comp1.dtopo1.theta_avg'});
model.study('std1').feature('topo').setIndex('constraintUbound', 'volfrac', 0);
model.study('std1').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std1').feature('topo').set('probesel', 'none');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'topo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
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
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40]);
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

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Topology Optimization');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg2');
model.nodeGroup.move('grp1', 1);

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Output material volume factor');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Threshold');

model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').add('plotgroup', 'pg4');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset1');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg3').feature('surf1').set('rangecoloractive', true);
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('rangecolormin', 0);
model.result('pg3').feature('surf1').set('rangecolormax', 1);
model.result('pg4').set('data', 'filt1');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', '1');
model.result('pg4').feature('surf1').set('coloring', 'uniform');
model.result('pg4').feature('surf1').set('color', 'gray');
model.result('pg4').feature('surf1').set('titletype', 'none');
model.result('pg1').run;

model.study('std1').feature('topo').set('plot', true);
model.study('std1').feature('topo').set('plotgroup', 'pg3');

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('o1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'topo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result.dataset.remove('rev1');
model.result.dataset('filt1').label('Filter - Max BL at Rest Optimization');
model.result.dataset('filt1').set('expr', 'if(isnan(dtopo1.theta_c),NaN,dtopo1.theta)');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').set('view', 'view1');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', 2);
model.result('pg1').run;
model.result('pg1').run;

model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').label('Max BL at Rest Optimization Results');

model.result('pg3').run;
model.result('pg3').set('view', 'view1');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'if(isnan(dtopo1.theta_c),NaN,dtopo1.theta)');
model.result('pg3').feature('surf1').set('descractive', true);
model.result('pg3').feature('surf1').set('descr', 'Output Material Volume Factor');
model.result('pg3').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').label('Study 2 - Flat BL Optimization');
model.study('std2').create('topo', 'TopologyOptimization');
model.study('std2').feature('topo').set('mmamaxiter', 50);
model.study('std2').feature('topo').set('optobj', {'comp1.obj_2'});
model.study('std2').feature('topo').set('descr', {'Point Probe - Objective 2'});
model.study('std2').feature('topo').set('objectivescaling', 'init');
model.study('std2').feature('topo').set('constraintExpression', {'comp1.dtopo1.theta_avg'});
model.study('std2').feature('topo').setIndex('constraintUbound', 'volfrac', 0);
model.study('std2').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std2').feature('topo').set('probesel', 'none');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'topo');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Magnetic Flux Density Norm (mf) 1');
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('dataisaxisym', 'off');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('solutionparams', 'parent');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('surf1').set('colorcalibration', -0.8);
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature.create('str1', 'Streamline');
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('solutionparams', 'parent');
model.result('pg5').feature('str1').set('titletype', 'none');
model.result('pg5').feature('str1').set('posmethod', 'uniform');
model.result('pg5').feature('str1').set('udist', 0.03);
model.result('pg5').feature('str1').set('maxlen', 0.4);
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('inheritcolor', false);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('showsolutionparams', 'on');
model.result('pg5').feature('str1').set('maxtime', Inf);
model.result('pg5').feature('str1').set('data', 'parent');
model.result('pg5').feature('str1').selection.geom('geom1', 1);
model.result('pg5').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40]);
model.result('pg5').feature('str1').set('inheritplot', 'surf1');
model.result('pg5').feature('str1').feature.create('col1', 'Color');
model.result('pg5').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg5').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg5').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg5').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg5').feature('str1').feature.create('filt1', 'Filter');
model.result('pg5').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg5').feature.create('con1', 'Contour');
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('solutionparams', 'parent');
model.result('pg5').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg5').feature('con1').set('titletype', 'none');
model.result('pg5').feature('con1').set('number', 10);
model.result('pg5').feature('con1').set('levelrounding', false);
model.result('pg5').feature('con1').set('coloring', 'uniform');
model.result('pg5').feature('con1').set('colorlegend', false);
model.result('pg5').feature('con1').set('color', 'custom');
model.result('pg5').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg5').feature('con1').set('resolution', 'fine');
model.result('pg5').feature('con1').set('inheritcolor', false);
model.result('pg5').feature('con1').set('showsolutionparams', 'on');
model.result('pg5').feature('con1').set('data', 'parent');
model.result('pg5').feature('con1').set('inheritplot', 'surf1');
model.result('pg5').feature('con1').feature.create('filt1', 'Filter');
model.result('pg5').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset3');
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Magnetic Flux Density Norm, Revolved Geometry (mf)');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').set('showlegendsmaxmin', true);
model.result('pg6').set('data', 'rev1');
model.result('pg6').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg6').feature.create('vol1', 'Volume');
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('solutionparams', 'parent');
model.result('pg6').feature('vol1').set('colortable', 'Prism');
model.result('pg6').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg6').feature('vol1').set('colorcalibration', -0.8);
model.result('pg6').feature('vol1').set('showsolutionparams', 'on');
model.result('pg6').feature('vol1').set('data', 'parent');
model.result('pg6').feature.create('con1', 'Contour');
model.result('pg6').feature('con1').set('showsolutionparams', 'on');
model.result('pg6').feature('con1').set('solutionparams', 'parent');
model.result('pg6').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg6').feature('con1').set('titletype', 'none');
model.result('pg6').feature('con1').set('number', 10);
model.result('pg6').feature('con1').set('levelrounding', false);
model.result('pg6').feature('con1').set('coloring', 'uniform');
model.result('pg6').feature('con1').set('colorlegend', false);
model.result('pg6').feature('con1').set('color', 'custom');
model.result('pg6').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg6').feature('con1').set('resolution', 'fine');
model.result('pg6').feature('con1').set('inheritcolor', false);
model.result('pg6').feature('con1').set('showsolutionparams', 'on');
model.result('pg6').feature('con1').set('data', 'parent');
model.result('pg6').feature('con1').set('inheritplot', 'vol1');
model.result('pg6').feature('con1').feature.create('filt1', 'Filter');
model.result('pg6').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg6').feature('con1').feature('filt1').set('shownodespec', 'on');

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').label('Topology Optimization');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg6');
model.nodeGroup.move('grp2', 2);

model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').label('Output material volume factor 1');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').label('Threshold 1');

model.nodeGroup('grp2').add('plotgroup', 'pg7');
model.nodeGroup('grp2').add('plotgroup', 'pg8');

model.result.dataset.create('filt2', 'Filter');
model.result.dataset('filt2').label('Filter');
model.result.dataset('filt2').set('data', 'dset3');
model.result.dataset('filt2').set('expr', 'dtopo1.theta');
model.result.dataset('filt2').set('lowerexpr', '0.5');
model.result.dataset('filt2').set('smooth', 'none');
model.result.dataset('filt2').set('useder', false);
model.result('pg7').set('data', 'dset3');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg7').feature('surf1').set('rangecoloractive', true);
model.result('pg7').feature('surf1').set('colortabletrans', 'none');
model.result('pg7').feature('surf1').set('rangecolormin', 0);
model.result('pg7').feature('surf1').set('rangecolormax', 1);
model.result('pg8').set('data', 'filt2');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', '1');
model.result('pg8').feature('surf1').set('coloring', 'uniform');
model.result('pg8').feature('surf1').set('color', 'gray');
model.result('pg8').feature('surf1').set('titletype', 'none');
model.result('pg5').run;

model.study('std2').feature('topo').set('plot', true);
model.study('std2').feature('topo').set('plotgroup', 'pg7');

model.sol('sol2').study('std2');
model.sol('sol2').feature.remove('o1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'topo');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg5').run;

model.study('std2').feature('topo').set('probewindow', '');

model.result.dataset.remove('rev1');
model.result.dataset('filt2').label('Filter - Flat BL Optimization');
model.result.dataset('filt2').set('expr', 'if(isnan(dtopo1.theta_c),NaN,dtopo1.theta)');
model.result.dataset.duplicate('filt3', 'filt2');
model.result.dataset('filt3').label('Filter - Initial Geometry');
model.result.dataset('filt3').set('expr', '1');
model.result('pg8').run;
model.result('pg8').set('view', 'view1');
model.result('pg8').run;
model.result('pg5').run;
model.result('pg5').set('view', 'view1');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('rangecoloractive', true);
model.result('pg5').feature('surf1').set('rangecolormax', 2);
model.result('pg5').run;
model.result('pg5').run;

model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').label('Flat BL Optimization Results');

model.result('pg7').run;
model.result('pg7').set('view', 'view1');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'if(isnan(dtopo1.theta_c),NaN,dtopo1.theta)');
model.result('pg7').feature('surf1').set('descractive', true);
model.result('pg7').feature('surf1').set('descr', 'Output Material Volume Factor');
model.result('pg7').run;
model.result.dataset('filt2').createMeshPart('mcomp1', 'mgeom1', 'mpart1', 'imp1');

model.mesh('mpart1').run('imp1');

model.result.dataset('filt3').createMeshPart('mcomp2', 'mgeom2', 'mpart2', 'imp1');

model.mesh('mpart2').run('imp1');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');
model.geom('geom2').axisymmetric(true);

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').lengthUnit('mm');
model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('type', 'mesh');
model.geom('geom2').feature('imp1').set('mesh', 'mpart1');
model.geom('geom2').run('imp1');
model.geom('geom2').create('imp2', 'Import');
model.geom('geom2').feature('imp2').set('type', 'mesh');
model.geom('geom2').feature('imp2').set('mesh', 'mpart2');
model.geom('geom2').run('imp2');

model.cpl.create('intop2', 'Integration', 'geom2');

model.geom('geom2').run;

model.cpl('intop2').set('axisym', true);
model.cpl('intop2').label('Area to Obtain the BL Factor 2');
model.cpl('intop2').set('opname', 'int_BL2');
model.cpl('intop2').selection.named('geom2_imp2_mpart2_imp1_geom1_r5_dom');
model.cpl('intop2').set('intorder', 30);
model.cpl('intop2').set('axisym', false);

model.variable.create('var3');
model.variable('var3').model('comp2');
model.variable('var3').label('Global Variables 2');
model.variable('var3').set('BL_integrand', '-mf2.Br*N0*2*pi*r/(w_coil*h_coil)', 'Integrand to obtain the BL factor');
model.variable('var3').set('coil_location_z', '(z>(dest(z)-h_coil/2))*(z<(dest(z)+h_coil/2))', 'Logical condition to discern the position of the coil');

model.material.create('matlnk3', 'Link', 'comp2');
model.material('matlnk3').label('Iron');
model.material('matlnk3').selection.named('geom2_imp1_mpart1_imp1_geom1_difsel1');
model.material.create('matlnk4', 'Link', 'comp2');
model.material('matlnk4').label('Magnet');
model.material('matlnk4').selection.named('geom2_imp2_mpart2_imp1_geom1_r4_dom');
model.material('matlnk4').set('link', 'mat2');

model.physics.create('mf2', 'InductionCurrents', 'geom2');
model.physics('mf2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/mf2', false);
model.study('std2').feature('stat').setSolveFor('/physics/mf2', false);

model.physics('mf2').create('als1', 'AmperesLawSolid', 2);
model.physics('mf2').feature('als1').label('Iron');
model.physics('mf2').feature('als1').selection.named('geom2_imp1_mpart1_imp1_geom1_difsel1');
model.physics('mf2').feature('als1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf2').create('als2', 'AmperesLawSolid', 2);
model.physics('mf2').feature('als2').label('Magnet');
model.physics('mf2').feature('als2').selection.named('geom2_imp2_mpart2_imp1_geom1_r4_dom');
model.physics('mf2').feature('als2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf2').feature('als2').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);

model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('map1').selection.named('geom2_imp2_mpart2_imp1_geom1_unisel1');
model.mesh('mesh2').feature('map1').create('size1', 'Size');
model.mesh('mesh2').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh2').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh2').feature('map1').feature('size1').set('hmax', 'mesh_size');
model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').create('size1', 'Size');
model.mesh('mesh2').feature('ftri1').feature('size1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('ftri1').feature('size1').selection.named('geom2_imp1_mpart1_imp1_geom1_difsel1');
model.mesh('mesh2').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmax', 'mesh_size');
model.mesh('mesh1').run;

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/mf', false);
model.study('std3').feature('stat').setSolveFor('/physics/mf2', true);
model.study('std3').feature('stat').set('probesel', 'none');
model.study('std3').label('Study 3 - Flat BL Validation');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').label('Magnetic Flux Density Norm (mf2)');
model.result('pg9').set('data', 'dset5');
model.result('pg9').set('dataisaxisym', 'off');
model.result('pg9').set('frametype', 'spatial');
model.result('pg9').set('showlegendsmaxmin', true);
model.result('pg9').set('data', 'dset5');
model.result('pg9').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg9').feature.create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('showsolutionparams', 'on');
model.result('pg9').feature('surf1').set('solutionparams', 'parent');
model.result('pg9').feature('surf1').set('colortable', 'Prism');
model.result('pg9').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg9').feature('surf1').set('colorcalibration', -0.8);
model.result('pg9').feature('surf1').set('showsolutionparams', 'on');
model.result('pg9').feature('surf1').set('data', 'parent');
model.result('pg9').feature.create('str1', 'Streamline');
model.result('pg9').feature('str1').set('showsolutionparams', 'on');
model.result('pg9').feature('str1').set('solutionparams', 'parent');
model.result('pg9').feature('str1').set('titletype', 'none');
model.result('pg9').feature('str1').set('posmethod', 'uniform');
model.result('pg9').feature('str1').set('udist', 0.03);
model.result('pg9').feature('str1').set('maxlen', 0.4);
model.result('pg9').feature('str1').set('maxtime', Inf);
model.result('pg9').feature('str1').set('inheritcolor', false);
model.result('pg9').feature('str1').set('showsolutionparams', 'on');
model.result('pg9').feature('str1').set('maxtime', Inf);
model.result('pg9').feature('str1').set('showsolutionparams', 'on');
model.result('pg9').feature('str1').set('maxtime', Inf);
model.result('pg9').feature('str1').set('showsolutionparams', 'on');
model.result('pg9').feature('str1').set('maxtime', Inf);
model.result('pg9').feature('str1').set('showsolutionparams', 'on');
model.result('pg9').feature('str1').set('maxtime', Inf);
model.result('pg9').feature('str1').set('data', 'parent');
model.result('pg9').feature('str1').selection.geom('geom2', 1);
model.result('pg9').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59]);
model.result('pg9').feature('str1').set('inheritplot', 'surf1');
model.result('pg9').feature('str1').feature.create('col1', 'Color');
model.result('pg9').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg9').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg9').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg9').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg9').feature('str1').feature.create('filt1', 'Filter');
model.result('pg9').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg9').feature.create('con1', 'Contour');
model.result('pg9').feature('con1').set('showsolutionparams', 'on');
model.result('pg9').feature('con1').set('solutionparams', 'parent');
model.result('pg9').feature('con1').set('expr', 'r*mf2.Aphi');
model.result('pg9').feature('con1').set('titletype', 'none');
model.result('pg9').feature('con1').set('number', 10);
model.result('pg9').feature('con1').set('levelrounding', false);
model.result('pg9').feature('con1').set('coloring', 'uniform');
model.result('pg9').feature('con1').set('colorlegend', false);
model.result('pg9').feature('con1').set('color', 'custom');
model.result('pg9').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg9').feature('con1').set('resolution', 'fine');
model.result('pg9').feature('con1').set('inheritcolor', false);
model.result('pg9').feature('con1').set('showsolutionparams', 'on');
model.result('pg9').feature('con1').set('data', 'parent');
model.result('pg9').feature('con1').set('inheritplot', 'surf1');
model.result('pg9').feature('con1').feature.create('filt1', 'Filter');
model.result('pg9').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset5');
model.result.create('pg10', 'PlotGroup3D');
model.result('pg10').label('Magnetic Flux Density Norm, Revolved Geometry (mf2)');
model.result('pg10').set('frametype', 'spatial');
model.result('pg10').set('showlegendsmaxmin', true);
model.result('pg10').set('data', 'rev1');
model.result('pg10').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg10').feature.create('vol1', 'Volume');
model.result('pg10').feature('vol1').set('showsolutionparams', 'on');
model.result('pg10').feature('vol1').set('solutionparams', 'parent');
model.result('pg10').feature('vol1').set('colortable', 'Prism');
model.result('pg10').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg10').feature('vol1').set('colorcalibration', -0.8);
model.result('pg10').feature('vol1').set('showsolutionparams', 'on');
model.result('pg10').feature('vol1').set('data', 'parent');
model.result('pg10').feature.create('con1', 'Contour');
model.result('pg10').feature('con1').set('showsolutionparams', 'on');
model.result('pg10').feature('con1').set('solutionparams', 'parent');
model.result('pg10').feature('con1').set('expr', 'r*mf2.Aphi');
model.result('pg10').feature('con1').set('titletype', 'none');
model.result('pg10').feature('con1').set('number', 10);
model.result('pg10').feature('con1').set('levelrounding', false);
model.result('pg10').feature('con1').set('coloring', 'uniform');
model.result('pg10').feature('con1').set('colorlegend', false);
model.result('pg10').feature('con1').set('color', 'custom');
model.result('pg10').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg10').feature('con1').set('resolution', 'fine');
model.result('pg10').feature('con1').set('inheritcolor', false);
model.result('pg10').feature('con1').set('showsolutionparams', 'on');
model.result('pg10').feature('con1').set('data', 'parent');
model.result('pg10').feature('con1').set('inheritplot', 'vol1');
model.result('pg10').feature('con1').feature.create('filt1', 'Filter');
model.result('pg10').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg10').feature('con1').feature('filt1').set('shownodespec', 'on');

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').label('Topology Optimization');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup('grp3').placeAfter('plotgroup', 'pg10');
model.nodeGroup.move('grp3', 3);

model.result.create('pg11', 'PlotGroup2D');
model.result('pg11').label('Output material volume factor 2');
model.result.create('pg12', 'PlotGroup2D');
model.result('pg12').label('Threshold 2');

model.nodeGroup('grp3').add('plotgroup', 'pg11');
model.nodeGroup('grp3').add('plotgroup', 'pg12');

model.result.dataset.create('filt4', 'Filter');
model.result.dataset('filt4').label('Filter');
model.result.dataset('filt4').set('data', 'dset4');
model.result.dataset('filt4').set('expr', 'dtopo1.theta');
model.result.dataset('filt4').set('lowerexpr', '0.5');
model.result.dataset('filt4').set('smooth', 'none');
model.result.dataset('filt4').set('useder', false);
model.result('pg11').set('data', 'dset4');
model.result('pg11').create('surf1', 'Surface');
model.result('pg11').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg11').feature('surf1').set('rangecoloractive', true);
model.result('pg11').feature('surf1').set('colortabletrans', 'none');
model.result('pg11').feature('surf1').set('rangecolormin', 0);
model.result('pg11').feature('surf1').set('rangecolormax', 1);
model.result('pg12').set('data', 'filt4');
model.result('pg12').create('surf1', 'Surface');
model.result('pg12').feature('surf1').set('expr', '1');
model.result('pg12').feature('surf1').set('coloring', 'uniform');
model.result('pg12').feature('surf1').set('color', 'gray');
model.result('pg12').feature('surf1').set('titletype', 'none');
model.result('pg9').run;
model.result('pg9').set('view', 'view1');
model.result('pg9').run;
model.result('pg9').feature('surf1').set('rangecoloractive', true);
model.result('pg9').feature('surf1').set('rangecolormin', 0);
model.result('pg9').feature('surf1').set('rangecolormax', 2);
model.result('pg9').run;
model.result('pg9').run;

model.nodeGroup('grp3').add('plotgroup', 'pg9');

model.result('pg11').run;
model.result.remove('pg11');
model.result.remove('pg12');
model.result('pg9').run;

model.nodeGroup('grp3').label('Flat BL Validation');

model.result.dataset.remove('dset4');
model.result.dataset.remove('rev1');
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').label('Traditional Design BL Curve');
model.result.table('tbl3').importData('magnetic_circuit_topology_optimization_traditional_bl.txt');
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').label('BL Factor');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', 'Voice coil offset (mm)');
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'BL factor (Wb/m)');
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('legendpos', 'lowermiddle');
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg10').feature('lngr1').set('linewidth', 'preference');
model.result('pg10').feature('lngr1').selection.named('geom1_ls1_bnd');
model.result('pg10').feature('lngr1').set('expr', 'int_BL(BL_integrand*coil_location_z)');
model.result('pg10').feature('lngr1').set('xdata', 'expr');
model.result('pg10').feature('lngr1').set('xdataexpr', '(z-z_coil)');
model.result('pg10').feature('lngr1').set('xdatadescractive', true);
model.result('pg10').feature('lngr1').set('xdatadescr', 'Coil Offset');
model.result('pg10').feature('lngr1').set('linewidth', 2);
model.result('pg10').feature('lngr1').set('legend', true);
model.result('pg10').feature('lngr1').set('autosolution', false);
model.result('pg10').feature('lngr1').set('legendprefix', 'Max BL at Rest Optimization');
model.result('pg10').run;
model.result('pg10').feature.duplicate('lngr2', 'lngr1');
model.result('pg10').run;
model.result('pg10').feature('lngr2').set('data', 'dset3');
model.result('pg10').feature('lngr2').set('legendprefix', 'Flat BL Optimization');
model.result('pg10').run;
model.result('pg10').feature.duplicate('lngr3', 'lngr2');
model.result('pg10').run;
model.result('pg10').feature('lngr3').set('data', 'dset5');
model.result('pg10').feature('lngr3').selection.named('geom2_imp2_mpart2_imp1_geom1_ls1_bnd');
model.result('pg10').feature('lngr3').set('expr', 'int_BL2(BL_integrand*coil_location_z)');
model.result('pg10').feature('lngr3').set('legendprefix', 'Flat BL Validation');
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').create('ann1', 'Annotation');
model.result('pg10').feature('ann1').set('showpoint', false);
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').create('tblp1', 'Table');
model.result('pg10').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg10').feature('tblp1').set('linewidth', 'preference');
model.result('pg10').feature('tblp1').set('table', 'tbl3');
model.result('pg10').run;
model.result('pg10').feature('tblp1').set('legend', true);
model.result('pg10').feature('tblp1').set('legendmethod', 'manual');
model.result('pg10').feature('tblp1').setIndex('legends', 'Traditional Design', 0);
model.result('pg10').feature('tblp1').set('linewidth', 2);
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').create('ptgr1', 'PointGraph');
model.result('pg10').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg10').feature('ptgr1').set('linewidth', 'preference');
model.result('pg10').feature('ptgr1').selection.named('geom1_pt2_pnt');
model.result('pg10').feature('ptgr1').set('expr', 'int_BL(BL_integrand*coil_location_z)');
model.result('pg10').feature('ptgr1').set('xdata', 'expr');
model.result('pg10').feature('ptgr1').set('xdataexpr', '(z-z_coil)');
model.result('pg10').feature('ptgr1').set('linestyle', 'none');
model.result('pg10').feature('ptgr1').set('linecolor', 'cyclereset');
model.result('pg10').feature('ptgr1').set('linewidth', 5);
model.result('pg10').feature('ptgr1').set('linemarker', 'diamond');
model.result('pg10').run;
model.result('pg10').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg10').run;
model.result('pg10').feature('ptgr2').set('data', 'dset3');
model.result('pg10').feature('ptgr2').selection.named('geom1_arr1_pnt');
model.result('pg10').run;
model.result('pg10').feature('ptgr2').set('linecolor', 'custom');
model.result('pg10').feature('ptgr2').set('customlinecolor', [0.3333333432674408 0.7843137383460999 0.40392157435417175]);
model.result('pg10').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Iron Volume');
model.result.evaluationGroup('eg1').set('data', 'none');
model.result.evaluationGroup('eg1').create('meas1', 'MeasureSurface');
model.result.evaluationGroup('eg1').feature('meas1').set('intvolume', true);
model.result.evaluationGroup('eg1').feature('meas1').set('data', 'filt1');
model.result.evaluationGroup('eg1').feature('meas1').set('unit', 'cm^3');
model.result.evaluationGroup('eg1').feature('meas1').set('descractive', true);
model.result.evaluationGroup('eg1').feature('meas1').set('descr', 'Max BL Opt');
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup('eg1').create('meas2', 'MeasureSurface');
model.result.evaluationGroup('eg1').feature('meas2').set('intvolume', true);
model.result.evaluationGroup('eg1').feature('meas2').set('data', 'filt2');
model.result.evaluationGroup('eg1').feature('meas2').set('unit', 'cm^3');
model.result.evaluationGroup('eg1').feature('meas2').set('descractive', true);
model.result.evaluationGroup('eg1').feature('meas2').set('descr', 'Flat BL Opt');
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup('eg1').create('meas3', 'MeasureSurface');
model.result.evaluationGroup('eg1').feature('meas3').set('intvolume', true);
model.result.evaluationGroup('eg1').feature('meas3').set('data', 'dset5');
model.result.evaluationGroup('eg1').feature('meas3').selection.set([3 10]);
model.result.evaluationGroup('eg1').feature('meas3').set('unit', 'cm^3');
model.result.evaluationGroup('eg1').feature('meas3').set('descractive', true);
model.result.evaluationGroup('eg1').feature('meas3').set('descr', 'Flat BL Validation');
model.result.evaluationGroup('eg1').run;
model.result('pg8').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg5').run;
model.result('pg7').run;
model.result('pg9').run;

model.title('Topology Optimization of a Magnetic Circuit');

model.description('This model presents two examples of topology optimization of the magnetic circuit of a loudspeaker driver. A first optimization is used to find the design of a nonlinear iron pole piece and top plate that maximize the BL factor at the resting position (small displacements), while constraining the amount of iron used. A second optimization is used to find a design of the magnetic circuit with a flat BL curve, while constraining the amount of iron used. This results in a design that reduces the nonlinearities for large displacements of the speaker cone. The design generated in the second optimization is validated in a new study, showing good agreement with the topology results. Both designs are compared with a traditional design showing improved performance while requiring a reduced amount of iron.');

model.mesh('mesh1').clearMesh;
model.mesh('mpart1').clearMesh;
model.mesh('mpart2').clearMesh;
model.mesh('mesh2').clearMesh;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('magnetic_circuit_topology_optimization.mph');

model.modelNode.label('Components');

out = model;
