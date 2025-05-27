function out = model
%
% dipolar_ecr_source.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Wave-Heated_Discharges');

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

model.geom('geom1').run;

model.physics('mf').create('alf1', 'AmperesLawFluid', 2);
model.physics('mf').feature('alf1').selection.all;

model.param.set('r0', '0.12');
model.param.descr('r0', 'Plasma source radius');
model.param.set('z0', '0.24');
model.param.descr('z0', 'Plasma source height');
model.param.set('Pin', '20[W]');
model.param.descr('Pin', 'Input power');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'r0' 'z0'});
model.geom('geom1').feature('r1').set('pos', {'0' '-z0/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [0.01 0.03]);
model.geom('geom1').feature('r2').set('pos', [0 0.04]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [0.004 0.048]);
model.geom('geom1').feature('r3').set('pos', [0.006 0.072]);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [0.004 0.05]);
model.geom('geom1').feature('r4').set('pos', [0 0.07]);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'r0-0.01' '0.02'});
model.geom('geom1').feature('r5').set('pos', [0.01 0.12]);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', [0.02 0.02]);
model.geom('geom1').feature('r6').set('pos', {'r0' '0.12'});
model.geom('geom1').run('r6');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', {'0.02' 'z0'});
model.geom('geom1').feature('r7').set('pos', {'r0' '-z0/2'});
model.geom('geom1').run('r7');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').set('size', [0.02 0.02]);
model.geom('geom1').feature('r8').set('pos', {'r0' '-0.02-z0/2'});
model.geom('geom1').run('r8');
model.geom('geom1').create('r9', 'Rectangle');
model.geom('geom1').feature('r9').set('size', {'r0' '0.02'});
model.geom('geom1').feature('r9').set('pos', {'0' '-0.02-z0/2'});
model.geom('geom1').run('r9');
model.geom('geom1').create('r10', 'Rectangle');
model.geom('geom1').feature('r10').set('size', [0.01 0.02]);
model.geom('geom1').feature('r10').set('pos', [0 0.12]);
model.geom('geom1').run('r10');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [0.01 0]);
model.geom('geom1').feature('ls1').set('coord2', [0.01 0]);
model.geom('geom1').feature('ls1').set('coord1', [0.01 0.072]);
model.geom('geom1').feature('ls1').set('coord2', [0.01 0.07]);
model.geom('geom1').runPre('fin');

model.view.create('view2', 'geom1');
model.view('view2').model('comp1');
model.view('view2').axis.set('xmin', -0.05);
model.view('view2').axis.set('xmax', 0.16);
model.view('view2').axis.set('ymin', -0.02);
model.view('view2').axis.set('ymax', 0.12);
model.view('view2').set('locked', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(1);
model.selection('sel1').set([4 6 18 19 20 22 26]);
model.selection('sel1').label('Walls');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');
model.coordSystem('ie1').selection.set([1 5 8 9 10 11]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([1 2 4 5 7 8 9 10 11]);
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([3]);
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'6e7'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([6]);
model.material('mat3').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'2'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([2]);
model.cpl('intop1').set('axisym', false);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.set([2]);

model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([3]);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('N', 5000);
model.physics('mf').feature('coil1').set('ICoil', 14);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([19]);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', '0.0005');
model.mesh('mesh1').create('edg2', 'Edge');
model.mesh('mesh1').feature('edg2').selection.set([6 18 20 22]);
model.mesh('mesh1').feature('edg2').create('size1', 'Size');
model.mesh('mesh1').feature('edg2').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('edg2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg2').feature('size1').set('hmax', 0.0015);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([2]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftri2', 'FreeTri');
model.mesh('mesh1').feature('ftri2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri2').selection.set([6]);
model.mesh('mesh1').feature('ftri2').create('size1', 'Size');
model.mesh('mesh1').feature('ftri2').feature('size1').set('hauto', 1);
model.mesh('mesh1').feature('ftri2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmax', 0.001);
model.mesh('mesh1').create('ftri3', 'FreeTri');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('errestandadap', 'adaption');
model.study('std1').feature('stat').set('meshadaptmethod', 'modify');
model.study('std1').feature('stat').set('errestim', 'goalerrest');
model.study('std1').feature('stat').set('goalfunctype', 'gfman');
model.study('std1').feature('stat').set('gfunc', 'comp1.intop1(1/(abs(comp1.mf.normB-0.0875)+1e-4))');
model.study('std1').feature('stat').set('meshadaptmethod', 'rebuild');
model.study('std1').feature('stat').set('userngen', true);
model.study('std1').label('Static Magnetic Field');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('adDef').set('maxscale', 1);
model.sol('sol1').runAll;

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.set([2 4 6 7]);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Stationary Magnetic Flux Density');
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'log10(mf.normB+eps)');
model.result('pg1').feature('con1').set('number', 8);
model.result('pg1').feature('con1').set('contourtype', 'filled');
model.result('pg1').feature('con1').set('colortable', 'GrayScale');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result('pg1').create('con2', 'Contour');
model.result('pg1').feature('con2').set('expr', 'Aphi');
model.result('pg1').feature('con2').set('coloring', 'uniform');
model.result('pg1').feature('con2').set('color', 'black');
model.result('pg1').feature('con2').set('colorlegend', false);
model.result('pg1').feature.duplicate('con3', 'con2');
model.result('pg1').run;
model.result('pg1').feature('con3').set('expr', 'mf.normB');
model.result('pg1').feature('con3').set('descr', 'Magnetic flux density norm');
model.result('pg1').feature('con3').set('levelmethod', 'levels');
model.result('pg1').feature('con3').set('levels', 'range(0.086,1.578947368421054e-4,0.089)');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Adaptive Mesh');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('mesh1', 'Mesh');
model.result('pg2').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh1').set('elemcolor', 'none');
model.result('pg2').feature('mesh1').set('wireframecolor', 'custom');
model.result('pg2').feature('mesh1').set('customwireframecolor', [0.7529411911964417 0.7529411911964417 0.7529411911964417]);
model.result('pg2').run;

model.physics.create('plas', 'ColdPlasma', 'geom1');
model.physics('plas').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/plas', false);

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/emw', false);

model.physics('emw').prop('ShapeProperty').set('order_electricfield', '1');

model.multiphysics.create('pcc1', 'PlasmaConductivityMultiphysicsCoupling', 'geom1', 2);

model.study('std1').feature('stat').setSolveFor('/multiphysics/pcc1', false);

model.multiphysics('pcc1').set('elm_physics', 'emw');
model.multiphysics('pcc1').set('plas_physics', 'plas');
model.multiphysics.create('ehs1', 'ElectronHeatSourceMultiphysicsCoupling', 'geom1', 2);

model.study('std1').feature('stat').setSolveFor('/multiphysics/ehs1', false);

model.multiphysics('ehs1').set('elm_physics', 'emw');
model.multiphysics('ehs1').set('plas_physics', 'plas');

model.physics('plas').selection.set([1 2 5 6 8 9 10 11]);
model.physics('emw').selection.set([2 6]);
model.physics('plas').prop('TransportSettings').set('fullDiffusivity', true);
model.physics('plas').prop('TransportSettings').set('IonTensorProps', true);
model.physics('plas').prop('ElectronProperties').set('TensorElectronProps', true);

model.multiphysics('pcc1').set('TensorSigma', true);
model.multiphysics('pcc1').set('dopplerb', 20);

model.physics('plas').selection.set([2]);
model.physics('plas').create('xsec1', 'CrossSectionImport', -1);
model.physics('plas').feature('xsec1').set('Filepath', 'Ar_xsecs.txt');
model.physics('plas').feature('xsec1').runCommand('importData');
model.physics('plas').create('rxn1', 'Reaction', 2);
model.physics('plas').feature('rxn1').set('formula', 'Ars+Ar=>Ar+Ar');
model.physics('plas').feature('rxn1').set('kf', 1807);
model.physics('plas').create('rxn2', 'Reaction', 2);
model.physics('plas').feature('rxn2').set('formula', 'Ars+Ars=>e+Ar+Ar+');
model.physics('plas').feature('rxn2').set('kf', '3.734E8');
model.physics('plas').feature('Ar').set('FromMassConstraint', true);
model.physics('plas').feature('Ar').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('Ars').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('Ars').set('x0', '1E-4');
model.physics('plas').feature('Ar_1p').set('InitIon', true);
model.physics('plas').feature('Ar_1p').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('Ar_1p').set('MobilityDiffusivitySpecification', 'SpecifyMobilityComputeDiffusivity');
model.physics('plas').feature('Ar_1p').set('MobilitySpecification', 'SpecifyLookupMobility');
model.physics('plas').feature('Ar_1p').set('efield_mueXdata', {'0' '0.000E+00' '1.931E+00' '2.414E+00' '2.897E+00' '3.621E+00' '4.828E+00' '6.035E+00' '7.242E+00' '9.656E+00'  ...
'1.207E+01' '1.448E+01' '1.931E+01' '2.414E+01' '2.897E+01' '3.621E+01' '4.828E+01' '6.035E+01' '7.242E+01' '9.656E+01'  ...
'1.207E+02' '1.448E+02' '1.931E+02' '2.414E+02' '2.897E+02' '3.621E+02' '4.828E+02' '5.251E+02' '6.001E+02' '6.751E+02'  ...
'7.501E+02' '1e3' '5e3' '1e5' '1e6'});
model.physics('plas').feature('Ar_1p').set('efield_mueYdata', [0 16.984765 16.984765 16.984765 16.984765 16.873843 16.762788 16.540811 16.318701 15.985669 15.652637 15.319605 14.653541 14.098532 13.54339 12.8773792 11.7672548 10.9901757 10.5461286 9.4360042 8.6589251 7.9928478 6.9937518 6.2166594 5.6616105 5.1065483 4.440471 4.2579019 3.9828978 3.7551087 3.5624183 3 1.5 1 0.8]);
model.physics('plas').create('sr1', 'SurfaceReaction', 1);
model.physics('plas').feature('sr1').set('formula', 'Ar+=>Ar');
model.physics('plas').feature('sr1').selection.named('sel1');
model.physics('plas').create('sr2', 'SurfaceReaction', 1);
model.physics('plas').feature('sr2').set('formula', 'Ars=>Ar');
model.physics('plas').feature('sr2').selection.named('sel1');
model.physics('plas').create('wall1', 'WallDriftDiffusion', 1);
model.physics('plas').feature('wall1').selection.named('sel1');
model.physics('plas').create('gnd1', 'Ground', 1);
model.physics('plas').feature('gnd1').selection.named('sel1');
model.physics('plas').feature('init1').set('neinit', '1E17[1/m^3]');
model.physics('plas').feature('init1').set('ebarinit', '2[V]');
model.physics('plas').feature('pes1').set('B_src', 'root.comp1.mf.Br');
model.physics('plas').feature('pes1').set('T', 300);
model.physics('plas').feature('pes1').set('pA', 1);
model.physics('plas').feature('pes1').set('mudc', '1E25[1/(m*V*s)]/plas.Nn');
model.physics('emw').create('port1', 'Port', 1);
model.physics('emw').feature('port1').selection.set([14]);
model.physics('emw').feature('port1').set('PortType', 'Coaxial');
model.physics('emw').feature('port1').set('Pin', 'Pin');

model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').create('rf1', 'Reference');
model.mesh('mesh2').feature('rf1').set('sequence', 'adaptmesh1');
model.mesh('mesh2').create('ref1', 'Refine');
model.mesh('mesh2').feature('ref1').selection.geom('geom1', 2);
model.mesh('mesh2').feature('ref1').selection.set([6]);
model.mesh('mesh2').feature('ref1').set('numrefine', 2);
model.mesh('mesh2').create('bl1', 'BndLayer');
model.mesh('mesh2').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh2').feature('bl1').selection.geom(2);
model.mesh('mesh2').feature('bl1').selection.set([]);
model.mesh('mesh2').feature('bl1').selection.allGeom;
model.mesh('mesh2').feature('bl1').selection.geom('geom1', 2);
model.mesh('mesh2').feature('bl1').selection.set([2]);
model.mesh('mesh2').feature('bl1').feature('blp').selection.named('sel1');
model.mesh('mesh2').feature('bl1').feature('blp').set('blnlayers', 4);
model.mesh('mesh2').feature('bl1').feature('blp').set('blstretch', 1.4);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('ftrans', 'FrequencyTransient');
model.study('std2').feature('ftrans').set('plotgroup', 'Default');
model.study('std2').feature('ftrans').set('initialtime', '0');
model.study('std2').feature('ftrans').set('freq', '1000');
model.study('std2').feature('ftrans').set('solnum', 'auto');
model.study('std2').feature('ftrans').set('notsolnum', 'auto');
model.study('std2').feature('ftrans').set('outputmap', {});
model.study('std2').feature('ftrans').setSolveFor('/physics/mf', false);
model.study('std2').feature('ftrans').setSolveFor('/physics/plas', true);
model.study('std2').feature('ftrans').setSolveFor('/physics/emw', true);
model.study('std2').feature('ftrans').setSolveFor('/multiphysics/pcc1', true);
model.study('std2').feature('ftrans').setSolveFor('/multiphysics/ehs1', true);
model.study('std2').feature('ftrans').set('tlist', '0 10^{range(-8,6/10,0)}');
model.study('std2').feature('ftrans').set('freq', 2.45E9);
model.study('std2').feature('ftrans').setEntry('activate', 'mf', false);
model.study('std2').feature('ftrans').setEntry('mesh', 'geom1', 'mesh2');
model.study('std2').feature('ftrans').set('usesol', true);
model.study('std2').feature('ftrans').set('notsolmethod', 'sol');
model.study('std2').feature('ftrans').set('notstudy', 'std1');
model.study('std2').feature('ftrans').set('notsol', 'sol2');
model.study('std2').feature('ftrans').set('notsoluse', 'sol4');

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'ftrans');
model.sol('sol5').feature('st1').set('splitcomplex', 'on');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_plas_Ar_1p_W').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_Ne').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_plas_Ars_W').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_En').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_V').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_plas_Ar_1p_W').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_Ne').set('scaleval', '35');
model.sol('sol5').feature('v1').feature('comp1_plas_Ars_W').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_En').set('scaleval', '35');
model.sol('sol5').feature('v1').feature('comp1_V').set('scaleval', '10');
model.sol('sol5').feature('v1').set('control', 'ftrans');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').set('tlist', '0 10^{range(-8,6/10,0)}');
model.sol('sol5').feature('t1').set('plot', 'off');
model.sol('sol5').feature('t1').set('plotgroup', 'Default');
model.sol('sol5').feature('t1').set('plotfreq', 'tout');
model.sol('sol5').feature('t1').set('probesel', 'all');
model.sol('sol5').feature('t1').set('probes', {});
model.sol('sol5').feature('t1').set('probefreq', 'tsteps');
model.sol('sol5').feature('t1').set('rtol', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol5').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol5').feature('t1').set('atolglobal', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol5').feature('t1').set('reacf', true);
model.sol('sol5').feature('t1').set('storeudot', true);
model.sol('sol5').feature('t1').set('endtimeinterpolation', true);
model.sol('sol5').feature('t1').set('estrat', 'exclude');
model.sol('sol5').feature('t1').set('maxorder', 2);
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol5').feature('t1').set('complex', true);
model.sol('sol5').feature('t1').set('control', 'ftrans');
model.sol('sol5').feature('t1').feature('aDef').set('complexfun', true);
model.sol('sol5').feature('t1').feature('aDef').set('cachepattern', false);
model.sol('sol5').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol5').feature('t1').feature('aDef').set('nullfun', 'flnullorth');
model.sol('sol5').feature('t1').create('seDef', 'Segregated');
model.sol('sol5').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol5').feature('t1').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol5').feature('t1').feature.remove('fcDef');
model.sol('sol5').feature('t1').feature.remove('seDef');
model.sol('sol5').attach('std2');
model.sol('sol5').feature('v1').set('control', 'user');

model.study('std2').label('Pin=20 W');

model.sol('sol5').study('std2');
model.sol('sol5').feature.remove('t1');
model.sol('sol5').feature.remove('v1');
model.sol('sol5').feature.remove('st1');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'ftrans');
model.sol('sol5').feature('st1').set('splitcomplex', 'on');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_plas_Ar_1p_W').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_Ne').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_plas_Ars_W').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_En').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_V').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_plas_Ar_1p_W').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_Ne').set('scaleval', '35');
model.sol('sol5').feature('v1').feature('comp1_plas_Ars_W').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_En').set('scaleval', '35');
model.sol('sol5').feature('v1').feature('comp1_V').set('scaleval', '10');
model.sol('sol5').feature('v1').set('control', 'ftrans');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').set('tlist', '0 10^{range(-8,6/10,0)}');
model.sol('sol5').feature('t1').set('plot', 'off');
model.sol('sol5').feature('t1').set('plotgroup', 'Default');
model.sol('sol5').feature('t1').set('plotfreq', 'tout');
model.sol('sol5').feature('t1').set('probesel', 'all');
model.sol('sol5').feature('t1').set('probes', {});
model.sol('sol5').feature('t1').set('probefreq', 'tsteps');
model.sol('sol5').feature('t1').set('rtol', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol5').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol5').feature('t1').set('atolglobal', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol5').feature('t1').set('reacf', true);
model.sol('sol5').feature('t1').set('storeudot', true);
model.sol('sol5').feature('t1').set('endtimeinterpolation', true);
model.sol('sol5').feature('t1').set('estrat', 'exclude');
model.sol('sol5').feature('t1').set('maxorder', 2);
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol5').feature('t1').set('complex', true);
model.sol('sol5').feature('t1').set('control', 'ftrans');
model.sol('sol5').feature('t1').feature('aDef').set('complexfun', true);
model.sol('sol5').feature('t1').feature('aDef').set('cachepattern', false);
model.sol('sol5').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol5').feature('t1').feature('aDef').set('nullfun', 'flnullorth');
model.sol('sol5').feature('t1').create('seDef', 'Segregated');
model.sol('sol5').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol5').feature('t1').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol5').feature('t1').feature.remove('fcDef');
model.sol('sol5').feature('t1').feature.remove('seDef');
model.sol('sol5').attach('std2');
model.sol('sol5').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 15, 0);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'plas.ne'});
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset3');
model.result('pg4').setIndex('looplevel', 15, 0);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'plas.Te'});
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset3');
model.result('pg5').setIndex('looplevel', 15, 0);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'V'});
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').set('colortable', 'Dipole');
model.result('pg3').label('Electron Density (plas)');
model.result('pg4').label('Electron Temperature (plas)');
model.result('pg5').label('Electric Potential (plas)');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Electric Field (emw)');
model.result('pg6').set('data', 'dset3');
model.result('pg6').setIndex('looplevel', 15, 0);
model.result('pg6').set('dataisaxisym', 'off');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').set('showlegendsmaxmin', true);
model.result('pg6').set('data', 'dset3');
model.result('pg6').setIndex('looplevel', 15, 0);
model.result('pg6').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').label('Surface');
model.result('pg6').feature('surf1').set('expr', 'emw.normE');
model.result('pg6').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset3');
model.result('pg3').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').add('plotgroup', 'pg4');
model.nodeGroup('grp1').add('plotgroup', 'pg5');
model.nodeGroup('grp1').add('plotgroup', 'pg6');
model.nodeGroup('grp1').label('Pin=20 W');

model.study.create('std3');
model.study('std3').create('fstat', 'FrequencyStationary');
model.study('std3').feature('fstat').set('plotgroup', 'Default');
model.study('std3').feature('fstat').set('freq', '1000000');
model.study('std3').feature('fstat').set('solnum', 'auto');
model.study('std3').feature('fstat').set('notsolnum', 'auto');
model.study('std3').feature('fstat').set('outputmap', {});
model.study('std3').feature('fstat').set('ngenAUX', '1');
model.study('std3').feature('fstat').set('goalngenAUX', '1');
model.study('std3').feature('fstat').set('ngenAUX', '1');
model.study('std3').feature('fstat').set('goalngenAUX', '1');
model.study('std3').feature('fstat').setSolveFor('/physics/mf', true);
model.study('std3').feature('fstat').setSolveFor('/physics/plas', true);
model.study('std3').feature('fstat').setSolveFor('/physics/emw', true);
model.study('std3').feature('fstat').setSolveFor('/multiphysics/pcc1', true);
model.study('std3').feature('fstat').setSolveFor('/multiphysics/ehs1', true);
model.study('std3').feature('fstat').set('freq', '2.45e9');
model.study('std3').feature('fstat').setEntry('activate', 'mf', false);
model.study('std3').feature('fstat').set('useinitsol', true);
model.study('std3').feature('fstat').set('initmethod', 'sol');
model.study('std3').feature('fstat').set('initstudy', 'std2');
model.study('std3').feature('fstat').set('usesol', true);
model.study('std3').feature('fstat').set('notsolmethod', 'sol');
model.study('std3').feature('fstat').set('notstudy', 'std1');
model.study('std3').feature('fstat').set('notsol', 'sol2');
model.study('std3').feature('fstat').set('useparam', true);
model.study('std3').feature('fstat').setIndex('pname', 'r0', 0);
model.study('std3').feature('fstat').setIndex('plistarr', '', 0);
model.study('std3').feature('fstat').setIndex('punit', '', 0);
model.study('std3').feature('fstat').setIndex('pname', 'r0', 0);
model.study('std3').feature('fstat').setIndex('plistarr', '', 0);
model.study('std3').feature('fstat').setIndex('punit', '', 0);
model.study('std3').feature('fstat').setIndex('pname', 'Pin', 0);
model.study('std3').feature('fstat').setIndex('plistarr', 'range(20,10,70) 73.5 75 80', 0);

model.sol.create('sol6');
model.sol('sol6').study('std3');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std3');
model.sol('sol6').feature('st1').set('studystep', 'fstat');
model.sol('sol6').feature('st1').set('splitcomplex', 'on');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').feature('comp1_plas_Ar_1p_W').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_Ne').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_plas_Ars_W').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_En').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_V').set('scalemethod', 'manual');
model.sol('sol6').feature('v1').feature('comp1_plas_Ar_1p_W').set('scaleval', '1');
model.sol('sol6').feature('v1').feature('comp1_Ne').set('scaleval', '35');
model.sol('sol6').feature('v1').feature('comp1_plas_Ars_W').set('scaleval', '1');
model.sol('sol6').feature('v1').feature('comp1_En').set('scaleval', '35');
model.sol('sol6').feature('v1').feature('comp1_V').set('scaleval', '10');
model.sol('sol6').feature('v1').set('control', 'fstat');
model.sol('sol6').create('s1', 'Stationary');
model.sol('sol6').feature('s1').set('stol', 1.0E-4);
model.sol('sol6').feature('s1').create('p1', 'Parametric');
model.sol('sol6').feature('s1').feature.remove('pDef');
model.sol('sol6').feature('s1').feature('p1').set('control', 'fstat');
model.sol('sol6').feature('s1').set('control', 'fstat');
model.sol('sol6').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol6').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol6').feature('s1').feature('aDef').set('matherr', false);
model.sol('sol6').feature('s1').feature('aDef').set('nullfun', 'flnullorth');
model.sol('sol6').feature('s1').create('seDef', 'Segregated');
model.sol('sol6').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol6').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('initstep', 1.0E-4);
model.sol('sol6').feature('s1').feature('fc1').set('minstep', 1.0E-8);
model.sol('sol6').feature('s1').feature('fc1').set('rstep', 1.5);
model.sol('sol6').feature('s1').feature('fc1').set('minsteprecovery', 0.01);
model.sol('sol6').feature('s1').feature('fc1').set('maxiter', 500);
model.sol('sol6').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol6').feature('s1').feature('fc1').set('termonres', false);
model.sol('sol6').feature('s1').create('d1', 'Direct');
model.sol('sol6').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol6').feature('s1').feature('d1').set('errorchk', 'off');
model.sol('sol6').feature('s1').feature('d1').label('Suggested Direct Solver (ehs1) (Merged)');
model.sol('sol6').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol6').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol6').feature('s1').feature('fc1').set('initstep', 1.0E-4);
model.sol('sol6').feature('s1').feature('fc1').set('minstep', 1.0E-8);
model.sol('sol6').feature('s1').feature('fc1').set('rstep', 1.5);
model.sol('sol6').feature('s1').feature('fc1').set('minsteprecovery', 0.01);
model.sol('sol6').feature('s1').feature('fc1').set('maxiter', 500);
model.sol('sol6').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol6').feature('s1').feature('fc1').set('termonres', false);
model.sol('sol6').feature('s1').feature.remove('fcDef');
model.sol('sol6').feature('s1').feature.remove('seDef');
model.sol('sol6').attach('std3');
model.sol('sol6').runAll;

model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevel', 9, 0);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', {'plas.ne'});
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset4');
model.result('pg8').setIndex('looplevel', 9, 0);
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'plas.Te'});
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').set('data', 'dset4');
model.result('pg9').setIndex('looplevel', 9, 0);
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', {'V'});
model.result('pg7').feature('surf1').set('colortable', 'Prism');
model.result('pg8').feature('surf1').set('colortable', 'Prism');
model.result('pg9').feature('surf1').set('colortable', 'Dipole');
model.result('pg7').label('Electron Density (plas) 1');
model.result('pg8').label('Electron Temperature (plas) 1');
model.result('pg9').label('Electric Potential (plas) 1');
model.result.create('pg10', 'PlotGroup2D');
model.result('pg10').label('Electric Field (emw) 1');
model.result('pg10').set('data', 'dset4');
model.result('pg10').setIndex('looplevel', 9, 0);
model.result('pg10').set('dataisaxisym', 'off');
model.result('pg10').set('frametype', 'spatial');
model.result('pg10').set('showlegendsmaxmin', true);
model.result('pg10').set('data', 'dset4');
model.result('pg10').setIndex('looplevel', 9, 0);
model.result('pg10').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg10').feature.create('surf1', 'Surface');
model.result('pg10').feature('surf1').label('Surface');
model.result('pg10').feature('surf1').set('expr', 'emw.normE');
model.result('pg10').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg10').feature('surf1').set('smooth', 'internal');
model.result('pg10').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').label('Revolution 2D 1');
model.result.dataset('rev2').set('data', 'none');
model.result.dataset('rev2').set('startangle', -90);
model.result.dataset('rev2').set('revangle', 225);
model.result.dataset('rev2').set('data', 'dset4');
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').set('data', 'dset4');
model.result('pg11').create('glob1', 'Global');
model.result('pg11').feature('glob1').set('unit', {''});
model.result('pg11').feature('glob1').set('expr', {'emw.S11dB'});
model.result('pg11').feature('glob1').set('descr', {'S11'});
model.result('pg11').label('S-parameter (emw)');
model.result('pg11').feature('glob1').set('titletype', 'none');
model.result('pg11').feature('glob1').set('xdata', 'expr');
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'S-parameter (dB)');
model.result('pg11').feature('glob1').set('xdataexpr', 'Pin');
model.result('pg11').feature('glob1').set('xdataunit', 'W');
model.result('pg11').feature('glob1').set('markerpos', 'datapoints');
model.result('pg11').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg12', 'SmithGroup');
model.result('pg12').set('data', 'dset4');
model.result('pg12').create('rgr1', 'ReflectionGraph');
model.result('pg12').feature('rgr1').set('unit', {''});
model.result('pg12').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg12').feature('rgr1').set('descr', {'S11'});
model.result('pg12').label('Smith Plot (emw)');
model.result('pg12').feature('rgr1').set('titletype', 'manual');
model.result('pg12').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg12').feature('rgr1').set('linemarker', 'point');
model.result('pg12').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg12').feature('rgr1').create('col1', 'Color');
model.result('pg12').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg12').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg7').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg2');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg7');
model.nodeGroup('grp2').add('plotgroup', 'pg8');
model.nodeGroup('grp2').add('plotgroup', 'pg9');
model.nodeGroup('grp2').add('plotgroup', 'pg10');
model.nodeGroup('grp2').add('plotgroup', 'pg11');
model.nodeGroup('grp2').add('plotgroup', 'pg12');
model.nodeGroup('grp2').label('Pin 20 to 80 W');

model.study('std3').label('Pin 20 to 80 W');

model.result('pg7').run;
model.result('pg7').setIndex('looplevel', 7, 0);
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 7, 0);
model.result('pg8').run;
model.result('pg9').run;
model.result('pg9').setIndex('looplevel', 7, 0);
model.result('pg9').run;
model.result('pg10').run;
model.result('pg10').setIndex('looplevel', 7, 0);
model.result('pg10').run;
model.result.create('pg13', 'PlotGroup1D');

model.nodeGroup('grp2').add('plotgroup', 'pg13');

model.result('pg13').run;
model.result('pg13').label('Absorbed Power vs. Input Power');
model.result('pg13').set('data', 'dset4');
model.result('pg13').set('showlegends', false);
model.result('pg13').set('titletype', 'none');
model.result('pg13').create('glob1', 'Global');
model.result('pg13').feature('glob1').set('markerpos', 'datapoints');
model.result('pg13').feature('glob1').set('linewidth', 'preference');
model.result('pg13').feature('glob1').setIndex('expr', 'intop2(emw.Qrh)', 0);
model.result('pg13').run;
model.result('pg13').run;
model.result('pg13').set('xlabelactive', true);
model.result('pg13').set('xlabel', 'Input Power (W)');
model.result('pg13').set('ylabelactive', true);
model.result('pg13').set('ylabel', 'Absorbed Power (W)');
model.result('pg13').run;
model.result.create('pg14', 'PlotGroup2D');

model.nodeGroup('grp2').add('plotgroup', 'pg14');

model.result('pg14').run;
model.result('pg14').set('data', 'dset4');
model.result('pg14').setIndex('looplevel', 7, 0);
model.result('pg14').label('Power Deposition');
model.result('pg14').create('surf1', 'Surface');
model.result('pg14').feature('surf1').set('expr', 'emw.Qrh');
model.result('pg14').feature('surf1').set('colortable', 'Prism');
model.result('pg14').run;
model.result('pg14').run;
model.result.duplicate('pg15', 'pg14');

model.nodeGroup('grp2').add('plotgroup', 'pg15');

model.result('pg15').run;
model.result('pg15').label('Electron Source');
model.result('pg15').run;
model.result('pg15').feature('surf1').set('expr', 'plas.Re');
model.result('pg15').run;
model.result('pg15').run;
model.result.duplicate('pg16', 'pg15');

model.nodeGroup('grp2').add('plotgroup', 'pg16');

model.result('pg16').run;
model.result('pg16').label('Electron Mobility, rr Component');
model.result('pg16').run;
model.result('pg16').feature('surf1').set('expr', 'plas.muerr');
model.result('pg16').run;
model.result('pg16').run;
model.result.duplicate('pg17', 'pg16');

model.nodeGroup('grp2').add('plotgroup', 'pg17');

model.result('pg17').run;
model.result('pg17').label('Electron Mobility, zz-Component');
model.result('pg17').run;
model.result('pg17').feature('surf1').set('expr', 'plas.muezz');
model.result('pg17').run;
model.result('pg17').run;
model.result.duplicate('pg18', 'pg17');

model.nodeGroup('grp2').add('plotgroup', 'pg18');

model.result('pg18').run;
model.result('pg18').label('Conduction Current Density, r-Component');
model.result('pg18').run;
model.result('pg18').feature('surf1').set('expr', 'emw.Jr-emw.Jdr');
model.result('pg18').run;
model.result('pg18').run;
model.result.duplicate('pg19', 'pg18');

model.nodeGroup('grp2').add('plotgroup', 'pg19');

model.result('pg19').run;
model.result('pg19').label('Conduction Current Density, z-Component');
model.result('pg19').run;
model.result('pg19').feature('surf1').set('expr', 'emw.Jz-emw.Jdz');
model.result('pg19').run;
model.result('pg19').run;
model.result.duplicate('pg20', 'pg19');

model.nodeGroup('grp2').add('plotgroup', 'pg20');

model.result('pg20').run;
model.result('pg20').label('Conduction Current Density, phi-Component');
model.result('pg20').run;
model.result('pg20').feature('surf1').set('expr', 'emw.Jphi-emw.Jdphi');
model.result('pg20').run;
model.result('pg20').run;
model.result.duplicate('pg21', 'pg20');

model.nodeGroup('grp2').add('plotgroup', 'pg21');

model.result('pg21').run;
model.result('pg21').label('Mean Plasma Electrical Conductivity');
model.result('pg21').run;
model.result('pg21').feature('surf1').set('expr', '(emw.sigmarr+emw.sigmaphiphi+emw.sigmazz)/3');
model.result('pg21').run;
model.result('pg7').run;
model.result('pg8').run;
model.result('pg9').run;
model.result('pg13').run;
model.result('pg14').run;
model.result('pg15').run;
model.result('pg16').run;
model.result('pg17').run;
model.result('pg18').run;
model.result('pg19').run;
model.result('pg20').run;
model.result('pg21').run;

model.title('Dipolar Microwave Plasma Source');

model.description(['A dipolar microwave plasma source sustained by electron cyclotron resonance (ECR) is studied. The power deposition into the plasma from the electromagnetic waves occurs in a very thin resonance zone where the static magnetic flux density is equal to the resonant flux density (0.0875 T).' newline  newline 'Requires the Plasma Module, AC/DC Module, and RF Module.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('dipolar_ecr_source.mph');

model.modelNode.label('Components');

out = model;
