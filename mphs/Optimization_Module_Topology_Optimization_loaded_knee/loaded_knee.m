function out = model
%
% loaded_knee.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('F_load', '10[kN]');
model.param.descr('F_load', 'Applied load');
model.param.set('h0', '7.5[mm]');
model.param.descr('h0', 'Mesh size');
model.param.set('WsRef', '1');
model.param.descr('WsRef', 'Reference strain energy');
model.param.set('WsMaxFactor', '1/0.4');
model.param.descr('WsMaxFactor', 'Maximum allowed relative strain energy');
model.param.set('d', '2[cm]');
model.param.descr('d', 'Bracket thickness');
model.param.set('beta', '1');
model.param.descr('beta', 'Projection slope');

model.geom('geom1').insertFile('loaded_knee_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');
model.material.create('matlnk1', 'Link', 'comp1');

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').set('projectionType', 'TanhProjection');
model.common('dtopo1').set('beta', 'beta');

model.massProp.create('mass1', 'MassProperties');
model.massProp('mass1').model('comp1');
model.massProp('mass1').set('densitySource', 'fromPhysics');

model.physics('solid').prop('Type2D').set('Type2D', 'PlaneStress');
model.physics('solid').prop('d').set('d', 'd');

model.material.create('toplnk1', 'TopologyLink', 'comp1');
model.material('toplnk1').set('topologySource', 'dtopo1');
model.material('toplnk1').selection.all;

model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([3]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.set([6]);
model.physics('solid').feature('bndl1').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl1').set('Ftot', {'0' '-F_load' '0'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'h0');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
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

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Topology Optimization');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg1');
model.nodeGroup.move('grp1', 1);

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Output material volume factor');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Threshold');

model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset1');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('rangecolormin', 0);
model.result('pg2').feature('surf1').set('rangecolormax', 1);
model.result('pg3').set('data', 'filt1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').feature('surf1').set('titletype', 'none');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Penalized Material Volume Factor');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'dtopo1.theta_p');
model.result('pg2').feature('surf1').set('descr', 'Penalized material volume factor');
model.result('pg2').feature('surf1').set('colortable', 'GrayScale');
model.result('pg2').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'solid.Ws_tot'});
model.result.numerical('gev1').set('descr', {'Total elastic strain energy'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.param.set('WsRef', '1.3[J]');

model.probe.create('var1', 'GlobalVariable');
model.probe('var1').model('comp1');
model.probe('var1').set('expr', 'dtopo1.theta_avg');
model.probe('var1').set('descr', 'Average material volume factor');
model.probe('var1').set('descractive', true);
model.probe('var1').set('descr', 'Solid fraction');
model.probe.create('var2', 'GlobalVariable');
model.probe('var2').model('comp1');
model.probe('var2').set('expr', 'solid.Ws_tot');
model.probe('var2').set('descr', 'Total elastic strain energy');
model.probe('var2').set('expr', 'solid.Ws_tot/WsRef');
model.probe('var2').set('descractive', true);
model.probe('var2').set('descr', 'Strain energy factor');

model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').feature('topo').set('mmamaxiter', 50);
model.study('std1').feature('topo').set('optobj', {'comp1.dtopo1.theta_avg'});
model.study('std1').feature('topo').set('descr', {'Average material volume factor'});
model.study('std1').feature('topo').set('constraintExpression', {'comp1.solid.Ws_tot'});
model.study('std1').feature('topo').setIndex('constraintExpression', 'comp1.solid.Ws_tot/WsRef', 0);
model.study('std1').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std1').feature('topo').setIndex('constraintUbound', '', 0);
model.study('std1').feature('topo').setIndex('constraintUbound', 'WsMaxFactor', 0);
model.study('std1').feature('topo').set('plot', true);
model.study('std1').feature('topo').set('plotgroup', 'pg2');
model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'F_load', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'N', 0);
model.study('std1').feature('param').setIndex('pname', 'F_load', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'N', 0);
model.study('std1').feature('param').setIndex('pname', 'beta', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 8', 0);
model.study('std1').feature('param').set('probesel', 'none');
model.study('std1').feature('param').set('reusesol', true);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
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
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'beta'});
model.batch('p1').set('plistarr', {'1 8'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'none');
model.batch('p1').set('probes', {'var1' 'var2'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');

model.probe('var1').genResult('none');
model.probe('var2').genResult('none');

model.batch('p1').run('compute');

model.result('pg1').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result('pg2').run;

model.title('Topology Optimization of a Loaded Knee Structure');

model.description('This example uses the solid isotropic material with penalization (SIMP) model to find the optimal distribution of a given amount of material forming an L-shaped frame. The optimality criterion is minimum compliance for the load case where the frame''s upper boundary is fixed and a downward load is applied along its right end.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('loaded_knee.mph');

model.modelNode.label('Components');

out = model;
