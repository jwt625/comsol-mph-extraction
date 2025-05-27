function out = model
%
% helmholtz_coil.m
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
model.physics.create('mfco', 'MagneticFieldsCurrentsOnly', 'geom1');
model.physics('mfco').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').feature('stat').setSolveFor('/physics/mfco', true);

model.param.set('I0', '0.25[mA]');
model.param.descr('I0', 'Coil current');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 0.05);
model.geom('geom1').feature('wp1').geom.feature('sq1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', [-0.4 0.2]);
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('size', 0.05);
model.geom('geom1').feature('wp1').geom.feature('sq2').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('pos', [-0.4 -0.2]);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').run('rev1');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 1.3);
model.geom('geom1').feature('sph1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sph1').setIndex('layer', 0.3, 0);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').selection('vertex1').set('sph1', 4);
model.geom('geom1').feature('ls1').selection('vertex2').set('sph1', 9);

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');

model.geom('geom1').run;

model.coordSystem('ie1').set('ScalingType', 'Spherical');
model.coordSystem('ie1').selection.set([1 2 3 4 8 9 10 11]);

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([6 10]);

model.physics('mf').create('coil1', 'Coil', 3);
model.physics('mf').feature('coil1').selection.set([6]);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('CoilType', 'Circular');
model.physics('mf').feature('coil1').set('ICoil', 'I0');
model.physics('mf').feature('coil1').feature('cre1').selection.set([25 26 46 49]);
model.physics('mf').create('coil2', 'Coil', 3);
model.physics('mf').feature('coil2').selection.set([7]);
model.physics('mf').feature('coil2').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil2').set('CoilType', 'Circular');
model.physics('mf').feature('coil2').set('ICoil', 'I0');
model.physics('mf').feature('coil2').feature('cre1').selection.set([30 31 72 75]);
model.physics('mfco').create('cond1', 'Conductor', 3);
model.physics('mfco').feature('cond1').selection.set([6]);
model.physics('mfco').feature('cond1').feature('term1').selection.set([13]);
model.physics('mfco').feature('cond1').feature('term1').set('I0', '10*I0');
model.physics('mfco').create('cond2', 'Conductor', 3);
model.physics('mfco').feature('cond2').selection.set([7]);
model.physics('mfco').feature('cond2').feature('term1').selection.set([20]);
model.physics('mfco').feature('cond2').feature('term1').set('I0', '10*I0');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Coil Insulator');
model.material('mat1').selection.set([6 7]);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'6e7[S/m]'});

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([40]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 50);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.set([5 6 7]);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([6 7]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 0.05);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').run;

model.study('std1').create('stat2', 'Stationary');
model.study('std1').feature('stat').setEntry('activate', 'mfco', false);
model.study('std1').feature('stat2').setEntry('activate', 'mf', false);
model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat2');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat2');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('se1', 'Segregated');
model.sol('sol1').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_A2'});
model.sol('sol1').feature('s2').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s2').feature('se1').feature('ss1').label('Magnetic Fields, Currents Only');
model.sol('sol1').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_mfco_cond1_Vdc' 'comp1_mfco_cond1_Vdc0' 'comp1_mfco_cond2_Vdc' 'comp1_mfco_cond2_Vdc0'});
model.sol('sol1').feature('s2').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s2').feature('se1').feature('ss2').label('Conductor Electric Potential ( Mfco )');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([6 7]);
model.selection('sel1').geom('geom1', 3, 2, {'exterior'});
model.selection('sel1').set([6 7]);
model.selection('sel1').label('Coils');

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.named('sel1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Magnetic Flux Density, MF');
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickznumber', 1);
model.result('pg1').feature('slc1').set('expr', 'mf.normB');
model.result('pg1').feature('slc1').set('descr', 'Magnetic flux density norm');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'mf.Hx' 'mf.Hy' 'mf.Hz'});
model.result('pg1').feature('arwv1').set('descr', 'Magnetic field');
model.result('pg1').feature('arwv1').set('xnumber', 24);
model.result('pg1').feature('arwv1').set('ynumber', 10);
model.result('pg1').feature('arwv1').set('znumber', 1);
model.result('pg1').feature('arwv1').set('scaleactive', true);
model.result('pg1').feature('arwv1').set('scale', 25);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'white');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Comparison of By');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').selection.set([40]);
model.result('pg2').feature('lngr1').set('expr', 'mf.By');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'y');
model.result('pg2').feature('lngr1').set('linemarker', 'cycle');
model.result('pg2').feature('lngr1').set('markerpos', 'interp');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('legendmethod', 'manual');
model.result('pg2').feature('lngr1').setIndex('legends', 'Magnetic Fields interface', 0);
model.result('pg2').feature.duplicate('lngr2', 'lngr1');
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('expr', 'mfco.By');
model.result('pg2').feature('lngr2').set('titletype', 'none');
model.result('pg2').feature('lngr2').setIndex('legends', 'Magnetic Fields, Currents Only interface', 0);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'uppermiddle');
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Comparison of Byy');
model.result('pg3').set('legendpos', 'lowerright');
model.result('pg3').run;
model.result('pg3').feature('lngr1').set('expr', 'd(laginterp(2,mf.By),y)');
model.result('pg3').run;
model.result('pg3').feature('lngr2').set('expr', 'd(mfco.By,y)');
model.result('pg3').run;
model.result('pg1').run;

model.title('Magnetic Field of a Helmholtz Coil');

model.description('A Helmholtz coil is a parallel pair of identical circular coils spaced one radius apart and wound so that the current flows through both coils in the same direction. This winding results in a uniform magnetic field between the coils with the primary component parallel to the axes of the two coils. The model shows how to compute the magnetic field and its higher derivatives using two different interfaces.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('helmholtz_coil.mph');

model.modelNode.label('Components');

out = model;
