function out = model
%
% force_calculation_02_magnetic_force_bem.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electromagnetic_Forces');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfncbe', 'MagneticFieldsNoCurrentsBoundaryElements', 'geom1');
model.physics('mfncbe').model('comp1');
model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');
model.physics.create('mfncbe2', 'MagneticFieldsNoCurrentsBoundaryElements', 'geom1');
model.physics('mfncbe2').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfncbe', true);
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std1').feature('stat').setSolveFor('/physics/mfncbe2', true);

model.geom('geom1').insertFile('force_calculation_01_introduction.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('hf', '1', 'Mesh scaling factor for pole fillet (used to test mesh convergence)');
model.param.set('Ap', 'pi*Rr^2', 'Magnetized rod, pole surface area');
model.param.set('cf', '2-1/sqrt(2)', 'Correction factor due to the fact that the model contains 4 poles (connected pairwise), instead of two monopoles');
model.param.set('qm', 'sqrt(4*pi*mu0_const*1[m/H]/cf)*1[Wb]', 'Amount of magnetic charge needed on the poles of a magnetized rod of 1[m] length, in order to achieve 1[N] of force with respect to a similar rod at 1[m] distance');
model.param.set('Brz', 'qm/Ap', 'Remanent flux density needed to achieve 1[N] of force (z component)');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Magnetized Rod Domain');
model.selection('sel1').set([3 4]);
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Magnetized Rod Surface');
model.selection('adj1').set('input', {'sel1'});
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Magnetized Rod Pole Surface');
model.selection('sel2').geom('geom1', 3, 2, {'exterior'});
model.selection('sel2').set([4]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Magnetized Rod Pole Fillet');
model.selection('sel3').geom(2);
model.selection('sel3').set([15 16 21 22 31 34 42 43]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Force Probe Domain');
model.selection('sel4').set([2 3 4]);
model.selection.create('adj2', 'Adjacent');
model.selection('adj2').model('comp1');
model.selection('adj2').label('Force Probe Surface');
model.selection('adj2').set('input', {'sel4'});
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('FEM-BEM Interface');
model.selection('sel5').geom(2);
model.selection('sel5').set('groupcontang', true);
model.selection('sel5').add([2 3 5 6]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.all;
model.material('mat1').selection.allVoids;
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});

model.physics('mfncbe').prop('Symmetry').setIndex('sym1', 'even', 0);
model.physics('mfncbe').prop('FarField').set('bemFarFieldTol', '1e-6');
model.physics('mfncbe').prop('BEMInfinityConditionProp').set('InfinityCondition', 'AsymptoticPotential');
model.physics('mfncbe').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('mfncbe').feature('mfc2').selection.named('sel4');
model.physics('mfncbe').create('mfc3', 'MagneticFluxConservation', 3);
model.physics('mfncbe').feature('mfc3').selection.named('sel1');
model.physics('mfncbe').feature('mfc3').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfncbe').feature('mfc3').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
model.physics('mfncbe').feature('mfc3').set('normBr_crel_BH_RemanentFluxDensity', 'Brz');
model.physics('mfncbe').feature('mfc3').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mfncbe').create('fcal1', 'ForceCalculation', 3);
model.physics('mfncbe').feature('fcal1').selection.named('sel1');
model.physics('mfncbe').feature('fcal1').set('ForceName', 'BEM_rod');
model.physics('mfncbe').create('fcal2', 'ForceCalculation', 3);
model.physics('mfncbe').feature('fcal2').selection.named('sel4');
model.physics('mfncbe').feature('fcal2').set('ForceName', 'BEM_probe');
model.physics('mfnc').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('mfnc').feature('mfc2').selection.named('sel1');
model.physics('mfnc').feature('mfc2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc2').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
model.physics('mfnc').feature('mfc2').set('normBr_crel_BH_RemanentFluxDensity', 'Brz');
model.physics('mfnc').feature('mfc2').set('e_crel_BH_RemanentFluxDensity', [0 0 1]);
model.physics('mfnc').create('fcal1', 'ForceCalculation', 3);
model.physics('mfnc').feature('fcal1').selection.named('sel1');
model.physics('mfnc').feature('fcal1').set('ForceName', 'FEM_rod');
model.physics('mfnc').create('fcal2', 'ForceCalculation', 3);
model.physics('mfnc').feature('fcal2').selection.named('sel4');
model.physics('mfnc').feature('fcal2').set('ForceName', 'FEM_probe');
model.physics('mfncbe2').selection.set([]);
model.physics('mfncbe2').selection.allVoids;
model.physics('mfncbe2').prop('Symmetry').setIndex('sym1', 'even', 0);
model.physics('mfncbe2').prop('BEMInfinityConditionProp').set('InfinityCondition', 'AsymptoticPotential');

model.multiphysics.create('msspc1', 'MagneticScalarScalarPotentialCoupling', 'geom1', 2);
model.multiphysics('msspc1').set('Vm_dst_physics', 'mfncbe2');
model.multiphysics('msspc1').selection.named('sel5');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('adj1');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('sel3');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'Rrf/hf');
model.mesh('mesh1').run;
model.mesh('mesh1').create('ftri2', 'FreeTri');
model.mesh('mesh1').feature('ftri2').selection.named('adj2');
model.mesh('mesh1').feature('ftri2').create('size1', 'Size');
model.mesh('mesh1').feature('ftri2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmax', 'Rr');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Rl', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'Rl', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'hf', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.5 1 2', 0);
model.study('std1').feature('stat').setEntry('activate', 'mfnc', false);
model.study('std1').feature('stat').setEntry('activate', 'mfncbe2', false);
model.study('std1').feature('stat').setEntry('activateCoupling', 'msspc1', false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (mfncbe)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i2').label('GMRES Iterative Solver (mfncbe)');
model.sol('sol1').feature('s1').feature('i2').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i2').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'dense');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (mfncbe)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'hf'});
model.batch('p1').set('plistarr', {'0.5 1 2'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Maxwell Surface Stress Tensor (BEM Rod)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('edges', false);
model.result('pg1').selection.geom('geom1', 2);
model.result('pg1').selection.named('sel2');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'sqrt(mfncbe.nToutx_BEM_rod^2+mfncbe.nTouty_BEM_rod^2+mfncbe.nToutz_BEM_rod^2)');
model.result('pg1').feature('surf1').set('descractive', true);
model.result('pg1').feature('surf1').set('descr', 'Maxwell surface stress tensor norm');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('expr', '0');
model.result('pg1').feature('surf2').set('titletype', 'none');
model.result('pg1').feature('surf2').set('coloring', 'uniform');
model.result('pg1').feature('surf2').set('color', 'black');
model.result('pg1').feature('surf2').set('wireframe', true);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Maxwell Surface Stress Tensor (BEM Probe)');
model.result('pg2').set('view', 'new');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'sqrt(mfncbe.nToutx_BEM_probe^2+mfncbe.nTouty_BEM_probe^2+mfncbe.nToutz_BEM_probe^2)');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Maxwell surface stress tensor norm');
model.result('pg2').run;

model.view('view4').set('showgrid', false);
model.view('view4').set('showaxisorientation', false);

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset2');
model.result.numerical('gev1').setIndex('expr', 'sqrt((mfncbe.Forcex_BEM_rod-1[N])^2+mfncbe.Forcey_BEM_rod^2+mfncbe.Forcez_BEM_rod^2)', 0);
model.result.numerical('gev1').setIndex('descr', 'Magnetic force error (BEM rod)', 0);
model.result.numerical('gev1').setIndex('expr', 'sqrt((mfncbe.Forcex_BEM_probe-1[N])^2+mfncbe.Forcey_BEM_probe^2+mfncbe.Forcez_BEM_probe^2)', 1);
model.result.numerical('gev1').setIndex('descr', 'Magnetic force error (BEM probe)', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.mesh.duplicate('mesh2', 'mesh1');
model.mesh('mesh2').create('ftet1', 'FreeTet');
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mfncbe', false);
model.study('std2').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std2').feature('stat').setSolveFor('/physics/mfncbe2', true);
model.study('std2').feature('stat').setSolveFor('/multiphysics/msspc1', true);
model.study('std2').setGenPlots(false);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'Rl', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'Rl', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'hf', 0);
model.study('std2').feature('param').setIndex('plistarr', '0.5 1 2 3 4 5', 0);

model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std2');
model.sol('sol6').feature('st1').set('studystep', 'stat');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').set('control', 'stat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').create('iDef', 'Iterative');
model.sol('sol6').feature('s1').create('seDef', 'Segregated');
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').create('i1', 'Iterative');
model.sol('sol6').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol6').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol6').feature('s1').feature('i1').label('Suggested Iterative Solver (msspc1) (Merged)');
model.sol('sol6').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol6').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol6').feature('s1').create('i2', 'Iterative');
model.sol('sol6').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol6').feature('s1').feature('i2').set('prefuntype', 'right');
model.sol('sol6').feature('s1').feature('i2').label('GMRES Iterative Solver (msspc1)');
model.sol('sol6').feature('s1').feature('i2').create('dp1', 'DirectPreconditioner');
model.sol('sol6').feature('s1').feature('i2').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol6').feature('s1').create('d1', 'Direct');
model.sol('sol6').feature('s1').feature('d1').set('linsolver', 'dense');
model.sol('sol6').feature('s1').feature('d1').label('Suggested Direct Solver (msspc1)');
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').feature('s1').feature.remove('seDef');
model.sol('sol6').feature('s1').feature.remove('iDef');
model.sol('sol6').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol6');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {'hf'});
model.batch('p2').set('plistarr', {'0.5 1 2 3 4 5'});
model.batch('p2').set('sweeptype', 'sparse');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param');

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol7');
model.batch('p2').run('compute');

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Maxwell Surface Stress Tensor (FEM Rod)');
model.result('pg3').set('data', 'dset4');
model.result('pg3').set('edges', false);
model.result('pg3').selection.geom('geom1', 2);
model.result('pg3').selection.named('sel2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'sqrt(mfnc.nToutx_FEM_rod^2+mfnc.nTouty_FEM_rod^2+mfnc.nToutz_FEM_rod^2)');
model.result('pg3').feature('surf1').set('descractive', true);
model.result('pg3').feature('surf1').set('descr', 'Maxwell surface stress tensor norm');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('expr', '0');
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'black');
model.result('pg3').feature('surf2').set('wireframe', true);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Maxwell Surface Stress Tensor (FEM Probe)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('view', 'view4');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'sqrt(mfnc.nToutx_FEM_probe^2+mfnc.nTouty_FEM_probe^2+mfnc.nToutz_FEM_probe^2)');
model.result('pg4').feature('surf1').set('descractive', true);
model.result('pg4').feature('surf1').set('descr', 'Maxwell surface stress tensor norm');
model.result('pg4').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset4');
model.result.numerical('gev2').setIndex('expr', 'sqrt((mfnc.Forcex_FEM_rod-1[N])^2+mfnc.Forcey_FEM_rod^2+mfnc.Forcez_FEM_rod^2)', 0);
model.result.numerical('gev2').setIndex('descr', 'Magnetic force error (FEM rod)', 0);
model.result.numerical('gev2').setIndex('expr', 'sqrt((mfnc.Forcex_FEM_probe-1[N])^2+mfnc.Forcey_FEM_probe^2+mfnc.Forcez_FEM_probe^2)', 1);
model.result.numerical('gev2').setIndex('descr', 'Magnetic force error (FEM probe)', 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Magnetic Force Error');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Mesh convergence of magnetic force');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Mesh scaling factor for pole fillet (hf)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Error with respect to analytical model');
model.result('pg5').create('tblp1', 'Table');
model.result('pg5').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg5').feature('tblp1').set('linewidth', 'preference');
model.result('pg5').feature('tblp1').set('linemarker', 'cycle');
model.result('pg5').feature('tblp1').set('legend', false);
model.result('pg5').run;
model.result('pg5').feature('tblp1').set('legend', true);
model.result('pg5').run;
model.result('pg5').create('tblp2', 'Table');
model.result('pg5').feature('tblp2').set('markerpos', 'datapoints');
model.result('pg5').feature('tblp2').set('linewidth', 'preference');
model.result('pg5').feature('tblp2').set('table', 'tbl2');
model.result('pg5').feature('tblp2').set('linemarker', 'cycle');
model.result('pg5').feature('tblp2').set('legend', true);
model.result('pg5').run;
model.result('pg5').set('ylog', true);
model.result('pg1').run;
model.result('pg1').run;

model.view('view1').set('showgrid', true);
model.view('view1').set('showaxisorientation', true);

model.result('pg1').run;

model.title(['Force Calculation 2 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Magnetic Force BEM FEM']);

model.description(['This verification model treats the case of two parallel magnetized rods of one meter length, placed one meter apart. The relative permeability is assumed to be one everywhere. The remanent flux density of the magnetized rods is chosen such that the analytical model predicts a repelling force between the two rods, of exactly one Newton.' newline  newline 'The boundary element method (BEM) and the finite element method (FEM) are compared to the analytical model for several mesh sizes. The quality of the Maxwell surface stress tensor on the poles is inspected. A parametric sweep is used to investigate mesh convergence for both BEM and FEM.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;

model.label('force_calculation_02_magnetic_force_bem.mph');

model.modelNode.label('Components');

out = model;
