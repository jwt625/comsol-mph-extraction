function out = model
%
% inductor_3d.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Inductive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'inductor_3d.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 0.2);
model.geom('geom1').feature('sph1').setIndex('layer', 0.05, 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([7 8 14]);
model.selection('sel1').label('Winding');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').set([9]);
model.selection('sel2').label('Gap');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').set([6]);
model.selection('sel3').label('Core');
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').set([1 2 3 4 10 11 12 13]);
model.selection('sel4').label('Infinite Elements');
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').set([1 2 3 4 5 6 9 10 11 12 13]);
model.selection('sel5').label('Nonconducting');
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').set([5 6 9]);
model.selection('sel6').label('Nonconducting without IE');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.named('sel4');
model.coordSystem('ie1').set('ScalingType', 'Spherical');

model.physics('mf').feature('fsp1').set('sigma_stab_mat', 'userdef');
model.physics('mf').feature('fsp1').set('sigma_stab', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.set([6]);
model.physics('mf').selection.set([1 2 3 4 5 6 7 8 10 11 12 13 14]);
model.physics('mf').create('coil1', 'Coil', 3);
model.physics('mf').feature('coil1').setIndex('materialType', 'solid', 0);
model.physics('mf').feature('coil1').selection.named('sel1');
model.physics('mf').feature('coil1').feature('ccc1').feature('ct1').selection.set([58]);
model.physics('mf').feature('coil1').feature('ccc1').create('cg1', 'CoilGround', 2);
model.physics('mf').feature('coil1').feature('ccc1').feature('cg1').selection.set([79]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('emissivity', '0.5');
model.material('mat1').propertyGroup('def').set('density', '8940[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '126e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.34');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material('mat1').selection.named('sel1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('sel3');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1e3'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat2').label('Core');

model.mesh('mesh1').run;

model.study('std1').create('ccc', 'CoilCurrentCalculation');
model.study('std1').feature.move('ccc', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('se1', 'Segregated');
model.sol('sol1').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_A'});
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 10000);
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').label('Magnetic Fields');
model.sol('sol1').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_mf_coil1_VCoil_ode'});
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').label('Coil Ode Variables');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('mslc1').set('colortable', 'Prism');
model.result('pg1').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('strmsl1').set('titletype', 'none');
model.result('pg1').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg1').feature('strmsl1').set('udist', 0.02);
model.result('pg1').feature('strmsl1').set('maxlen', 0.4);
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('inheritcolor', false);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('data', 'parent');
model.result('pg1').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg1').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg1').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result.dataset.duplicate('dset3', 'dset1');
model.result.dataset('dset3').selection.geom('geom1', 3);
model.result.dataset('dset3').selection.named('sel1');
model.result.dataset.duplicate('dset4', 'dset1');
model.result.dataset('dset4').selection.geom('geom1', 3);
model.result.dataset('dset4').selection.named('sel3');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('|B| and Coil Direction');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'mf.coil1.eCoilx' 'mf.coil1.eCoily' 'mf.coil1.eCoilz'});
model.result('pg2').feature('str1').set('descr', 'Coil direction');
model.result('pg2').feature('str1').selection.set([58]);
model.result('pg2').run;
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('data', 'dset4');
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'mf.RCoil_1', 0);
model.result.numerical('gev1').setIndex('expr', 'mf.LCoil_1', 1);
model.result.numerical('gev1').setIndex('expr', 'mf.VCoil_1/mf.ICoil_1', 2);
model.result.numerical('gev1').setIndex('descr', 'Voltage drop definition', 2);
model.result.numerical('gev1').setIndex('expr', '2*mf.intWm/mf.ICoil_1^2', 3);
model.result.numerical('gev1').setIndex('descr', 'Inductance via magnetic energy density', 3);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.physics('mf').selection.set([5 6 7 8 14]);

model.sol('sol1').study('std1');
model.sol('sol2').copySolution('sol3');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('s2');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset6');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('se1', 'Segregated');
model.sol('sol1').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_A'});
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 10000);
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').label('Magnetic Fields');
model.sol('sol1').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_mf_coil1_VCoil_ode'});
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').label('Coil Ode Variables');
model.sol('sol1').feature('s2').feature.remove('fcDef');

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;

model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study('std1').feature('ccc').setSolveFor('/physics/cir', true);
model.study('std1').feature('stat').setSolveFor('/physics/cir', true);

model.physics('mf').feature('coil1').set('CoilExcitation', 'CircuitCurrent');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 1, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('R1').set('R', '100[mohm]');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.mf.VCoil_1');
model.physics('cir').feature('IvsU1').setIndex('Connections', 2, 0, 0);
model.physics('cir').feature('IvsU1').setIndex('Connections', 0, 1, 0);

model.sol('sol1').study('std1');
model.sol('sol2').copySolution('sol3');

model.result.dataset('dset2').set('solution', 'none');

model.sol('sol1').feature.remove('s2');
model.sol('sol1').feature.remove('v2');
model.sol('sol1').feature.remove('st2');
model.sol('sol1').feature.remove('su1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol3').copySolution('sol2');
model.sol.remove('sol3');
model.sol('sol2').label('Solution Store 1');

model.result.dataset.remove('dset6');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').feature('su1').set('sol', 'sol2');
model.sol('sol1').feature('su1').label('Solution Store 1');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('iDef', 'Iterative');
model.sol('sol1').feature('s2').create('seDef', 'Segregated');
model.sol('sol1').feature('s2').create('se1', 'Segregated');
model.sol('sol1').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_currents' 'comp1_A'});
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s2').feature('i1').set('rhob', 10000);
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('hybridvar', {'comp1_A' 'comp1_mf_coil1_ccc1_p' 'comp1_mf_coil1_VCoil_ode'});
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s2').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s2').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s2').feature('i1').feature('dp1').set('hybridvar', {'comp1_currents'});
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol1').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_mf_coil1_VCoil_ode'});
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').label('Coil Ode Variables');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('s2').feature.remove('seDef');
model.sol('sol1').feature('s2').feature.remove('iDef');

model.result.dataset('dset2').set('solution', 'sol2');

model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('expr', 'mf.ICoil_1', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/mf', true);
model.study('std2').feature('freq').setSolveFor('/physics/cir', false);

model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').set([7 8 14]);
model.selection('sel7').geom('geom1', 3, 2, {'exterior'});
model.selection('sel7').set([7 8 14]);
model.selection('sel7').label('Conductor Boundaries');

model.physics('mf').create('als2', 'AmperesLawSolid', 3);
model.physics('mf').feature('als2').selection.named('sel3');
model.physics('mf').feature('als2').set('ConstitutiveRelationBH', 'MagneticLosses');
model.physics('mf').feature('als2').set('murPrim_mat', 'userdef');
model.physics('mf').feature('als2').set('murBis_mat', 'userdef');
model.physics('mf').feature('als2').set('murPrim', 1200);
model.physics('mf').feature('als2').set('murBis', 100);

model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat3').label('Copper 1');
model.material('mat3').set('family', 'copper');
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('emissivity', '0.5');
model.material('mat3').propertyGroup('def').set('density', '8940[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '126e9[Pa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.34');
model.material('mat3').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat3').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat3').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat3').propertyGroup('linzRes').addInput('temperature');
model.material('mat3').selection.geom('geom1', 2);
model.material('mat3').selection.named('sel7');

model.physics('mf').selection.named('sel6');
model.physics('mf').create('imp1', 'Impedance', 2);
model.physics('mf').feature('imp1').selection.named('sel7');
model.physics('mf').feature('coil1').active(false);
model.physics('mf').feature('als1').active(false);
model.physics('mf').create('lport1', 'LumpedPort', 2);
model.physics('mf').feature('lport1').selection.set([59 60 61 62]);
model.physics('mf').feature('lport1').set('PortType', 'UserDefined');

model.view('view1').set('showDirections', false);

model.physics('mf').feature('lport1').set('hPort', 0.024);
model.physics('mf').feature('lport1').set('wPort', 0.046);
model.physics('mf').feature('lport1').set('ahPort', [1 0 0]);
model.physics('mf').feature('lport1').set('TerminalType', 'Current');

model.study('std2').feature('freq').set('punit', 'MHz');
model.study('std2').feature('freq').set('plist', 'range(1,0.25,10)');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'range(1,0.25,10)'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'MHz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std2');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Magnetic Flux Density Norm (mf) 1');
model.result('pg3').set('data', 'dset5');
model.result('pg3').setIndex('looplevel', 37, 0);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset5');
model.result('pg3').setIndex('looplevel', 37, 0);
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond1/pg1');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('solutionparams', 'parent');
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'mf.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'mf.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'mf.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Prism');
model.result('pg3').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg3').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result('pg3').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'mf.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'mf.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'mf.CPz');
model.result('pg3').feature('strmsl1').set('titletype', 'none');
model.result('pg3').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg3').feature('strmsl1').set('udist', 0.02);
model.result('pg3').feature('strmsl1').set('maxlen', 0.4);
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('inheritcolor', false);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg3').feature('strmsl1').set('maxtime', Inf);
model.result('pg3').feature('strmsl1').set('data', 'parent');
model.result('pg3').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg3').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg3').run;
model.result.dataset.duplicate('dset6', 'dset5');
model.result.dataset('dset6').selection.geom('geom1', 2);
model.result.dataset('dset6').selection.named('sel7');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Surface Current Density');
model.result('pg4').set('data', 'dset6');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'mf.normJs');
model.result('pg4').feature('surf1').set('descr', 'Surface current density norm');
model.result('pg4').run;
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Coil Impedance');
model.result('pg5').set('data', 'dset5');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('twoyaxes', true);
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').run;
model.result('pg5').create('glob2', 'Global');
model.result('pg5').feature('glob2').set('markerpos', 'datapoints');
model.result('pg5').feature('glob2').set('linewidth', 'preference');
model.result('pg5').run;
model.result('pg5').feature('glob1').set('expr', {'mf.Zport_1'});
model.result('pg5').feature('glob1').set('descr', {'Lumped port 1 impedance'});
model.result('pg5').feature('glob1').set('unit', {['ohm' ]});
model.result('pg5').feature('glob1').setIndex('expr', 'real(mf.Zport_1)', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Real part of impedance', 0);
model.result('pg5').run;
model.result('pg5').feature('glob2').set('plotonsecyaxis', true);
model.result('pg5').feature('glob2').setIndex('expr', 'imag(mf.Zport_1)', 0);
model.result('pg5').feature('glob2').setIndex('descr', 'Imaginary part of impedance', 0);
model.result('pg5').run;
model.result('pg2').run;

model.study('std1').feature('stat').setEntry('activate', 'mf', false);

model.view('view1').set('showgrid', true);

model.title('Modeling of a 3D Inductor');

model.description('Inductors are important parts of many applications. This example shows how to extract both DC and AC properties of an inductor.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('inductor_3d.mph');

model.modelNode.label('Components');

out = model;
