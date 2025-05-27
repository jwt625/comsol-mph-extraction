function out = model
%
% mbb_beam_optimization.m
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
model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').feature('topo').setSolveFor('/physics/solid', true);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;

model.material.create('toplnk1', 'TopologyLink', 'comp1');
model.material('toplnk1').set('topologySource', 'dtopo1');
model.material('toplnk1').selection.all;

model.physics('solid').prop('ShapeProperty').set('order_displacement', 1);

model.study('std1').feature('topo').setIndex('optobj', 'comp1.solid.Ws_tot', 0);
model.study('std1').feature('topo').set('objectivescaling', 'init');
model.study('std1').feature('topo').setIndex('constraintExpression', 'comp1.dtopo1.theta_avg', 0);
model.study('std1').feature('topo').setIndex('constraintUbound', '0.5', 0);

model.param.set('a', '3 [m]');
model.param.descr('a', 'Beam half width');
model.param.set('b', '1 [m]');
model.param.descr('b', 'Beam height');
model.param.set('L1', '0.1 [m]');
model.param.descr('L1', 'Support width');
model.param.set('meshsz', '6 [cm]');
model.param.descr('meshsz', 'Mesh size');
model.param.set('volfrac', '0.5');
model.param.descr('volfrac', 'Maximum volume fraction');
model.param.set('beta', '1');
model.param.descr('beta', 'Projection slope');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'a' 'b'});
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'L1', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 'a-L1/2', 0);
model.geom('geom1').feature('pt2').setIndex('p', 'b', 1);
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Load Boundary');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('xmin', 'a-L1/1.999');
model.geom('geom1').feature('boxsel1').set('ymin', 'b*0.999');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Symmetry y');
model.geom('geom1').feature('boxsel2').set('entitydim', 1);
model.geom('geom1').feature('boxsel2').set('xmax', 'a*0.001');
model.geom('geom1').feature('boxsel2').set('ymax', 'L1*1.001');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Symmetry x');
model.geom('geom1').feature('boxsel3').set('entitydim', 1);
model.geom('geom1').feature('boxsel3').set('xmin', 'a*0.999');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');

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
model.material('toplnk1').set('link', 'mat1');

model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.named('geom1_boxsel3');
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.named('geom1_boxsel2');
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').selection.named('geom1_boxsel1');
model.physics('solid').feature('bndl1').set('LoadType', 'TotalForce');
model.physics('solid').feature('bndl1').set('Ftot', {'0' '-100 [kN]' '0'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'meshsz');
model.mesh('mesh1').run;

model.param.set('volfrac', '0.5', 'Maximum volume fraction');
model.param.set('volfrac', '0.5');
model.param.descr('volfrac', 'Maximum volume fraction');
model.param.set('beta', '1', 'Projection slope');
model.param.set('beta', '1');
model.param.descr('beta', 'Projection slope');

model.common('dtopo1').set('projectionType', 'TanhProjection');
model.common('dtopo1').set('beta', 'beta');
model.common('dtopo1').set('theta_0', 'volfrac');

model.study('std1').label('Optimization');
model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'a', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'a', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'b', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'b', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'beta', 0);
model.study('std1').feature('param').setIndex('plistarr', '1 8', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'meshsz', 1);
model.study('std1').feature('param').setIndex('plistarr', '6 3', 1);
model.study('std1').feature('param').setIndex('punit', 'cm', 1);
model.study('std1').feature('param').set('reusesol', true);

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
model.batch('p1').set('pname', {'beta' 'meshsz'});
model.batch('p1').set('plistarr', {'1 8' '6 3'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').getInitialValue;

model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').setIndex('genpoints', 'a', 0, 0);
model.result.dataset('mir1').setIndex('genpoints', 'a', 1, 0);
model.result.dataset('mir1').set('data', 'dset2');
model.result.dataset('mir1').set('hasvar', true);
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').set('data', 'dset1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');
model.result('pg1').label('Topology');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'if(mir1side,dtopo1.theta_c,dtopo1.theta_f)');
model.result('pg1').feature('surf1').set('descractive', true);
model.result('pg1').feature('surf1').set('descr', 'theta_c (left) and theta_f (right)');
model.result('pg1').feature('surf1').set('colortable', 'GrayScale');
model.result('pg1').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').set('data', 'mir2');
model.result('pg2').label('Topology 2');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'if(mir1side,dtopo1.theta_f,dtopo1.theta)');
model.result('pg2').feature('surf1').set('descr', 'theta_f (left) and theta (right)');

model.study('std1').feature('topo').set('mmamaxiter', 50);
model.study('std1').feature('topo').setIndex('constraintExpression', 'comp1.dtopo1.theta_avg', 0);
model.study('std1').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std1').feature('topo').setIndex('constraintUbound', 'volfrac', 0);
model.study('std1').feature('topo').set('plot', true);
model.study('std1').feature('topo').set('plotgroup', 'pg2');

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
model.sol('sol1').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch('p1').feature.remove('so1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').set('pname', {'beta' 'meshsz'});
model.batch('p1').set('plistarr', {'1 8' '6 3'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').set('control', 'param');
model.batch('p1').run('compute');

model.result('pg1').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('titletype', 'none');
model.result('pg1').feature('surf1').set('colorlegend', false);

model.view('view2').set('showgrid', false);

model.result('pg1').run;

model.view('view2').set('showgrid', true);

model.result('pg1').run;
model.result('pg1').feature('surf1').set('titletype', 'auto');
model.result('pg1').feature('surf1').set('colorlegend', true);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('titletype', 'none');
model.result('pg2').feature('surf1').set('colorlegend', false);

model.view('view3').set('showgrid', false);

model.result('pg2').run;

model.view('view3').set('showgrid', true);

model.result('pg2').run;
model.result('pg2').feature('surf1').set('titletype', 'auto');
model.result('pg2').feature('surf1').set('colorlegend', true);
model.result('pg2').feature('surf1').set('expr', 'solid.E');
model.result('pg2').feature('surf1').set('descractive', false);
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'if(mir1side,dtopo1.theta_f,dtopo1.theta)');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'theta_f (left) and theta (right)');
model.result('pg2').feature('surf1').set('colortable', 'GrayScale');
model.result('pg2').feature('surf1').set('colortabletrans', 'reverse');

model.title('Topology Optimization of an MBB Beam');

model.description(['This example demonstrates topology optimization with the Optimization Module in the context of the Messerschmitt' native2unicode(hex2dec({'20' '13'}), 'unicode') 'B' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'lkow' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Blohm beam benchmark problem.']);

model.label('mbb_beam_optimization.mph');

model.modelNode.label('Components');

out = model;
