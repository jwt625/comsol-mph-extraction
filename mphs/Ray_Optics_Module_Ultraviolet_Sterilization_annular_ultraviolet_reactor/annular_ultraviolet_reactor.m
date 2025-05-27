function out = model
%
% annular_ultraviolet_reactor.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Ultraviolet_Sterilization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.set('r_lamp', '1[cm]');
model.param.descr('r_lamp', 'Lamp radius');
model.param.set('r_reac', '5[cm]');
model.param.descr('r_reac', 'Reactor radius');
model.param.set('L_reac', '100[cm]');
model.param.descr('L_reac', 'Reactor length');
model.param.set('L_lamp', '80[cm]');
model.param.descr('L_lamp', 'Lamp length');
model.param.set('d_lamp', 'L_reac-L_lamp');
model.param.descr('d_lamp', 'Lamp displacement');
model.param.set('mid_lamp', 'd_lamp+L_lamp/2');
model.param.descr('mid_lamp', 'Lamp midplane location');
model.param.set('P', '40[W]');
model.param.descr('P', 'Total source power');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').label('Reactor');
model.geom('geom1').feature('cyl1').set('r', 'r_reac');
model.geom('geom1').feature('cyl1').set('h', 'L_reac');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').label('Lamp');
model.geom('geom1').feature('cyl2').set('r', 'r_lamp');
model.geom('geom1').feature('cyl2').set('h', 'L_lamp');
model.geom('geom1').feature('cyl2').set('pos', {'0' '0' 'd_lamp'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl2'});
model.geom('geom1').run('fin');

model.cpl.create('genproj1', 'GeneralProjection', 'geom1');
model.cpl('genproj1').selection.set([1]);
model.cpl('genproj1').set('srcmap', {'sqrt(x^2+y^2)' 'y' 'z'});
model.cpl('genproj1').setIndex('srcmap', 'z', 1);
model.cpl('genproj1').setIndex('srcmap', 'atan2(y,x)', 2);
model.cpl('genproj1').set('dstmap', {'sqrt(x^2+y^2)' 'y'});
model.cpl('genproj1').setIndex('dstmap', 'z', 1);

model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').prop('OnlyStoreAccumulatedVariables').setIndex('OnlyStoreAccumulatedVariables', 1, 0);
model.physics('gop').prop('IntensityComputation').setIndex('IntensityComputation', 'ComputePower', 0);
model.physics('gop').feature('op1').set('lambda0', '254[nm]');
model.physics('gop').feature('mp1').set('n_mat', 'userdef');
model.physics('gop').feature('mp1').set('n', [1.38 0 0 0 1.38 0 0 0 1.38]);
model.physics('gop').feature('mp1').set('OpticalAttenuationModel', 'InternalTransmittance10');
model.physics('gop').feature('mp1').set('taui10_mat', 'userdef');
model.physics('gop').feature('mp1').set('taui10', 0.7);
model.physics('gop').create('relb1', 'ReleaseFromBoundary', 2);
model.physics('gop').feature('relb1').selection.set([5 6 9 10]);
model.physics('gop').feature('relb1').set('InitialPosition', 'Density');
model.physics('gop').feature('relb1').setIndex('Nr', 100000, 0);
model.physics('gop').feature('relb1').set('RayDirectionVector', 'Lambertian');
model.physics('gop').feature('relb1').set('SpecifyInletTangentialNormal', true);
model.physics('gop').feature('relb1').setIndex('Nw', 1, 0);
model.physics('gop').feature('relb1').set('rax', [0 0 1]);
model.physics('gop').feature('relb1').set('SamplingFromDistribution', 'Random');
model.physics('gop').feature('relb1').set('Psrc', 'P');
model.physics('gop').create('frc1', 'FluenceRateCalculation', 3);
model.physics('gop').feature('frc1').selection.set([1]);
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').selection.all;
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').selection.set([1 2 3 4 8 11]);

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').label('Study 1: Absorbing Walls');
model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('llist', '0 0.2');
model.study('std1').feature('rtrac').set('useadvanceddisable', true);
model.study('std1').feature('rtrac').set('disabledphysics', {'gop/mir1'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_qgop').set('out', 'off');
model.sol('sol1').feature('v1').feature('comp1_gop_atten').set('out', 'off');
model.sol('sol1').feature('v1').feature('comp1_gop_fi').set('out', 'off');
model.sol('sol1').feature('v1').feature('comp1_gop_Q0').set('out', 'off');
model.sol('sol1').feature('v1').feature('comp1_kgop').set('out', 'off');
model.sol('sol1').feature('v1').feature('comp1_gop_s').set('out', 'off');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Fluence Rate Slice Plot');
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'gop.frc1.E0');
model.result('pg1').feature('slc1').set('descr', 'Fluence rate');
model.result('pg1').feature('slc1').set('unit', 'mW/cm^2');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').feature('slc1').set('resolution', 'norefine');
model.result('pg1').feature('slc1').set('colortable', 'Magma');
model.result('pg1').feature('slc1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('slc1').set('colorcalibration', -1.5);
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 'r_lamp', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'mid_lamp', 0, 2);
model.result.dataset('cln1').setIndex('genpoints', 'r_reac', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'mid_lamp', 1, 2);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Fluence Rate Radial Distribution');
model.result('pg2').set('data', 'cln1');
model.result('pg2').setIndex('looplevelinput', 'last', 0);
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('expr', 'genproj1(gop.frc1.E0)/genproj1(1)');
model.result('pg2').feature('lngr1').set('unit', 'mW/cm^2');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('xdataunit', 'cm');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Azimuthally averaged fluence rate', 0);
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('expr', 'gop.frc1.E0');
model.result('pg2').feature('lngr2').setIndex('legends', 'Fluence rate along cut line', 0);
model.result('pg2').feature.duplicate('lngr3', 'lngr2');
model.result('pg2').run;
model.result('pg2').feature('lngr3').set('expr', 'P/L_lamp/(2*pi*x)*0.7^((x-r_lamp)/1[cm])');
model.result('pg2').feature('lngr3').setIndex('legends', 'Simplified radial model', 0);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('rtrac', 'RayTracing');
model.study('std2').feature('rtrac').setSolveFor('/physics/gop', true);
model.study('std2').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std2').feature('rtrac').set('llist', '0 0.2');
model.study('std2').label('Study 2: Reflecting Walls');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'rtrac');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_qgop').set('out', 'off');
model.sol('sol2').feature('v1').feature('comp1_gop_atten').set('out', 'off');
model.sol('sol2').feature('v1').feature('comp1_gop_fi').set('out', 'off');
model.sol('sol2').feature('v1').feature('comp1_gop_Q0').set('out', 'off');
model.sol('sol2').feature('v1').feature('comp1_kgop').set('out', 'off');
model.sol('sol2').feature('v1').feature('comp1_gop_s').set('out', 'off');
model.sol('sol2').feature('v1').set('control', 'rtrac');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 1.0E-5);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', false);
model.sol('sol2').feature('t1').set('storeudot', false);
model.sol('sol2').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'rtrac');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').set('data', 'dset2');
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Absorbing vs Reflecting Reactor');
model.result('pg3').run;
model.result('pg3').feature.remove('lngr2');
model.result('pg3').feature.remove('lngr3');
model.result('pg3').run;
model.result('pg3').feature('lngr1').setIndex('legends', 'Fluence rate, absorbing walls', 0);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('data', 'cln2');
model.result('pg3').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg3').feature('lngr2').setIndex('legends', 'Fluence rate, reflecting walls', 0);
model.result('pg3').run;

model.title('Annular Ultraviolet Reactor');

model.description('This model demonstrates how to compute the volumetric fluence rate in an ultraviolet (UV) reactor. The geometry is the annular fluid region surrounding a cylindrical lamp. The effect of reflection at the reactor walls on the radial fluence rate distribution is considered.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('annular_ultraviolet_reactor.mph');

model.modelNode.label('Components');

out = model;
