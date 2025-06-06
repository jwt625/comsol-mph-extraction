function out = model
%
% chloroprene_rubber_compression_test.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Viscoplasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.param.label('Geometrical Parameters');
model.param.set('H', '13[mm]');
model.param.descr('H', 'Height of test specimen');
model.param.set('D', '28[mm]');
model.param.descr('D', 'Diameter of test specimen');
model.param.set('A0', 'pi*D^2/4');
model.param.descr('A0', 'surface area of test specimen');
model.param.create('par2');
model.param('par2').label('Strain History Data');
model.param('par2').set('edot', '0.002[1/s]');
model.param('par2').descr('edot', 'True strain rate');
model.param('par2').set('Dt', '150[s]');
model.param('par2').descr('Dt', 'Time before relaxation');
model.param('par2').set('Rt', '120[s]');
model.param('par2').descr('Rt', 'Relaxation time');
model.param('par2').set('endTime', '1280[s]');
model.param('par2').descr('endTime', 'Total simulation time');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'D/2' 'H/2'});
model.geom('geom1').run('r1');
model.geom('geom1').runPre('fin');

model.func.create('pw1', 'Piecewise');
model.func('pw1').model('comp1');
model.func('pw1').set('arg', 'time');
model.func('pw1').setIndex('pieces', 0, 0, 0);
model.func('pw1').setIndex('pieces', 'Dt', 0, 1);
model.func('pw1').setIndex('pieces', 'edot*time', 0, 2);
model.func('pw1').setIndex('pieces', 'Dt', 1, 0);
model.func('pw1').setIndex('pieces', 'Dt+Rt', 1, 1);
model.func('pw1').setIndex('pieces', 'edot*Dt', 1, 2);
model.func('pw1').setIndex('pieces', 'Dt+Rt', 2, 0);
model.func('pw1').setIndex('pieces', '2*Dt+Rt', 2, 1);
model.func('pw1').setIndex('pieces', 'edot*(time-Rt)', 2, 2);
model.func('pw1').setIndex('pieces', '2*Dt+Rt', 3, 0);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)', 3, 1);
model.func('pw1').setIndex('pieces', '2*edot*Dt', 3, 2);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)', 4, 0);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)+2*Dt/3', 4, 1);
model.func('pw1').setIndex('pieces', 'edot*(time-2*Rt)', 4, 2);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)+2*Dt/3', 5, 0);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)+4*Dt/3', 5, 1);
model.func('pw1').setIndex('pieces', '1+edot*(2*(Dt+Rt)-time)', 5, 2);
model.func('pw1').setIndex('pieces', '2*(Dt+Rt)+4*Dt/3', 6, 0);
model.func('pw1').setIndex('pieces', '2*Dt+3*Rt+4*Dt/3', 6, 1);
model.func('pw1').setIndex('pieces', '2*edot*Dt', 6, 2);
model.func('pw1').setIndex('pieces', '2*Dt+3*Rt+4*Dt/3', 7, 0);
model.func('pw1').setIndex('pieces', '3*(Dt+Rt)+4*Dt/3', 7, 1);
model.func('pw1').setIndex('pieces', '0.4+edot*(3*Rt+4*Dt-time)', 7, 2);
model.func('pw1').setIndex('pieces', '3*(Dt+Rt)+4*Dt/3', 8, 0);
model.func('pw1').setIndex('pieces', '3*Dt+4*Rt+4*Dt/3', 8, 1);
model.func('pw1').setIndex('pieces', 'edot*Dt', 8, 2);
model.func('pw1').setIndex('pieces', '3*Dt+4*Rt+4*Dt/3', 9, 0);
model.func('pw1').setIndex('pieces', '4*(Dt+Rt)+4*Dt/3', 9, 1);
model.func('pw1').setIndex('pieces', '0.4+edot*(4*Rt+4*Dt-time)', 9, 2);
model.func('pw1').set('argunit', 's');
model.func('pw1').set('fununit', '1');
model.func('pw1').label('Logarithmic Strain');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([3]);
model.cpl('aveop1').label('Top Surface Average');

model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics('solid').create('symp1', 'SymmetryPlane', 1);
model.physics('solid').feature('symp1').selection.set([2]);
model.physics('solid').create('hmm1', 'HyperelasticModel', 2);
model.physics('solid').feature('hmm1').set('MaterialModel', 'ArrudaBoyce');
model.physics('solid').feature('hmm1').set('Compressibility_ArrudaBoyce', 'CompressibleUncoupled');
model.physics('solid').feature('hmm1').set('VolumetricEnergyUncoupled', 'miehe');
model.physics('solid').feature('hmm1').selection.set([1]);
model.physics('solid').feature('hmm1').create('pvp1', 'PolymerViscoplasticity', 2);
model.physics('solid').feature('hmm1').feature('pvp1').set('betav', 1.6);
model.physics('solid').feature('hmm1').feature('pvp1').set('timeMethod', 'ode');
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '0.5*H*(exp(-pw1(t))-1)', 2);
model.physics('solid').feature('disp1').selection.set([3]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('KG', 'Bulk_modulus_and_shear_modulus');
model.material('mat1').propertyGroup('KG').set('K', {'2[GPa]'});
model.material('mat1').propertyGroup.create('ArrudaBoyce', 'Arruda-Boyce');
model.material('mat1').propertyGroup('ArrudaBoyce').set('Nseg', {'8'});
model.material('mat1').propertyGroup('ArrudaBoyce').set('mu0', {'0.6[MPa]'});
model.material('mat1').propertyGroup('def').set('density', {'0'});
model.material('mat1').propertyGroup.create('BergstromBoyce', 'Bergstrom-Boyce_viscoplasticity');
model.material('mat1').propertyGroup('BergstromBoyce').set('A_BB', {'7*sqrt(2/3)[1/s]'});
model.material('mat1').propertyGroup('BergstromBoyce').set('sigRes_BB', {'sqrt(3)[MPa]'});
model.material('mat1').propertyGroup('BergstromBoyce').set('n_BB', {'4'});
model.material('mat1').propertyGroup('BergstromBoyce').set('sigmaco_BB', {'0'});
model.material('mat1').propertyGroup('BergstromBoyce').set('c_BB', {'-1'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run;

model.study('std1').label('Nonequilibrium Modeling');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', 'range(0,8,endTime)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evpe').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evpe').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evpe').set('scaleval', '0.001');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.015435349040433134');
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evp').set('scaleval', '0.001');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,8,endTime)');
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
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', 0.005);
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evpe').set('scaleval', 1);
model.sol('sol1').feature('v1').feature('comp1_solid_hmm1_pvp1_evp').set('scaleval', 1);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').runAll;

model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'xy');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Displacements');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Displacement magnitude [mm]');
model.result('pg1').set('paramindicator', 'Time=eval(t) s');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('vol1').create('def1', 'Deform');
model.result('pg1').feature('vol1').feature('def1').set('revcoordsys', 'cylindrical');
model.result('pg1').run;
model.result('pg1').feature('vol1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('vol1').feature('def1').set('scale', 1);
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Stretch History');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Deformation Gradient');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Stretch (1)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'aveop1(solid.FdzZ)', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Total stretch', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'aveop1(solid.hmm1.pvp1.Fvpl33)', 1);
model.result('pg2').feature('glob1').setIndex('descr', 'Viscoplastic stretch', 1);
model.result('pg2').feature('glob1').setIndex('expr', 'aveop1(solid.hmm1.pvp1.Fvpil33*solid.FdzZ)', 2);
model.result('pg2').feature('glob1').setIndex('descr', 'Elastic stretch', 2);
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'center');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('True Stress');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'True Stress');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'True strain (1)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'True stress (MPa)');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'aveop1(-solid.szz)', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'MPa', 0);
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'aveop1(abs(solid.elogzz))');
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'Comsol', 0);
model.result('pg3').run;
model.result('pg3').set('legendpos', 'upperleft');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Reference Results');
model.result.table('tbl1').importData('chloroprene_rubber_compression_test_numerical.txt');
model.result('pg3').run;
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('linestyle', 'none');
model.result('pg3').feature('tblp1').set('linemarker', 'circle');
model.result('pg3').feature('tblp1').set('legend', true);
model.result('pg3').feature('tblp1').set('legendmethod', 'manual');
model.result('pg3').feature('tblp1').setIndex('legends', 'Reference', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').label('Experimental Results');
model.result.table('tbl2').importData('chloroprene_rubber_compression_test_experimental.txt');
model.result('pg3').run;
model.result('pg3').create('tblp2', 'Table');
model.result('pg3').feature('tblp2').set('markerpos', 'datapoints');
model.result('pg3').feature('tblp2').set('linewidth', 'preference');
model.result('pg3').feature('tblp2').set('table', 'tbl2');
model.result('pg3').feature('tblp2').set('linestyle', 'none');
model.result('pg3').feature('tblp2').set('linemarker', 'circle');
model.result('pg3').feature('tblp2').set('legend', true);
model.result('pg3').feature('tblp2').set('legendmethod', 'manual');
model.result('pg3').feature('tblp2').setIndex('legends', 'Experiments', 0);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('glob1').create('comp1', 'Comparison');
model.result('pg3').run;
model.result('pg3').feature('glob1').feature('comp1').set('metric', 'r2');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Inelastic Force Contribution');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Normalized Inelastic Force: P<SUB>33</SUB>A<SUB>0</SUB>/max(P<SUB>33</SUB>A<SUB>0</SUB>)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Normalized force (1)');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'aveop1(abs(solid.elogzz))', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'True strain', 0);
model.result('pg4').feature('glob1').set('linewidth', 2);
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').label('Max Inelastic Force');
model.result.numerical('pev1').selection.set([2]);
model.result.numerical('pev1').setIndex('expr', 'timemax(0,endTime,abs(solid.Fdlz3*solid.Siel33*A0))', 0);
model.result.numerical('pev1').setIndex('looplevelinput', 'first', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Max Inelastic Force');
model.result.numerical('pev1').set('table', 'tbl3');
model.result.numerical('pev1').setResult;
model.result('pg4').run;
model.result('pg4').feature('glob1').setIndex('expr', 'aveop1(abs(solid.Fdlz3*solid.Siel33*A0)/146.75[N])', 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Inelastic force', 1);
model.result('pg4').run;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/solid', true);
model.study('std2').label('Equilibrium Modeling');
model.study('std2').setGenPlots(false);
model.study('std2').feature('time').set('tlist', 'range(0,8,endTime)');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'solid/hmm1/pvp1'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.015435349040433134');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,8,endTime)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.001);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', 0.005);
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Nonequilibrium vs. Equilibrium');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'True Stress');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'True strain (1)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'True stress (MPa)');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').label('Nonequilibrium');
model.result('pg5').feature('glob1').setIndex('expr', 'aveop1(-solid.szz)', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'MPa', 0);
model.result('pg5').feature('glob1').set('linewidth', 2);
model.result('pg5').feature('glob1').set('autoplotlabel', true);
model.result('pg5').feature('glob1').set('autosolution', false);
model.result('pg5').feature('glob1').set('autodescr', false);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'aveop1(abs(solid.elogzz))');
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob2').label('Equilibrium');
model.result('pg5').feature('glob2').set('data', 'dset2');
model.result('pg5').run;
model.result('pg5').feature.duplicate('glob3', 'glob1');
model.result('pg5').run;
model.result('pg5').feature('glob3').label('Difference');
model.result('pg5').feature('glob3').setIndex('expr', 'aveop1(-solid.szz)-withsol(''sol2'',aveop1(-solid.szz),setval(t,t))', 0);
model.result('pg5').run;

model.func('pw1').createPlot('pg6');

model.result('pg6').run;
model.result('pg6').label('True Strain History');
model.result('pg6').set('title', 'True strain history');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Time (s)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'True strain (1)');
model.result('pg6').set('axislimits', true);
model.result('pg6').set('xmin', 0);
model.result('pg6').set('xmax', 'endTime');
model.result('pg6').set('manualgrid', true);
model.result('pg6').set('xspacing', 100);
model.result('pg6').set('yspacing', 0.2);
model.result('pg6').run;
model.result('pg6').feature('plot1').set('linewidth', 2);
model.result('pg6').run;
model.result('pg6').run;
model.result.remove('pg6');
model.result.dataset.remove('pw1_ds1');
model.result('pg5').run;

model.title('Chloroprene Rubber Compression Test');

model.description(['In this example, the Bergstrom' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Boyce material model is used to capture the nonequilibrium behavior of carbon-black-filled chloroprene rubber under a strain history that alternates compression with relaxation. Results are verified against experimental and numerical results taken from the literature.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('chloroprene_rubber_compression_test.mph');

model.modelNode.label('Components');

out = model;
