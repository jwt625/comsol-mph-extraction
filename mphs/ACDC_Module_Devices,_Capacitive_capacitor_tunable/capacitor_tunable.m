function out = model
%
% capacitor_tunable.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Capacitive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('esbe', 'ElectrostaticsBoundaryElements', 'geom1');
model.physics('esbe').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/esbe', true);

model.geom('geom1').insertFile('capacitor_tunable_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Ground Plane');
model.selection('sel1').set([2]);
model.selection('sel1').geom('geom1', 3, 2, {'exterior'});
model.selection('sel1').set([2]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Terminal');
model.selection('sel2').set([1]);
model.selection('sel2').geom('geom1', 3, 2, {'exterior'});
model.selection('sel2').set([1]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Dielectric');
model.material('mat1').selection.set([]);
model.material('mat1').selection.allVoids;
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.2'});

model.physics('esbe').selection.set([]);
model.physics('esbe').selection.allVoids;
model.physics('esbe').create('gnd1', 'Ground', 2);
model.physics('esbe').feature('gnd1').selection.named('sel1');
model.physics('esbe').create('term1', 'Terminal', 2);
model.physics('esbe').feature('term1').selection.named('sel2');
model.physics('esbe').feature('term1').set('TerminalType', 'Voltage');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

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
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (esbe)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i2').label('GMRES Iterative Solver (esbe)');
model.sol('sol1').feature('s1').feature('i2').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i2').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'dense');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (esbe)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('d1').active(true);
model.sol('sol1').runAll;

model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('data', 'dset1');
model.result.dataset('grid1').set('par1', 'x');
model.result.dataset('grid1').set('par2', 'y');
model.result.dataset('grid1').set('par3', 'z');
model.result.dataset('grid1').set('parmin1', -400);
model.result.dataset('grid1').set('parmax1', 680);
model.result.dataset('grid1').set('parmin2', -300);
model.result.dataset('grid1').set('parmax2', 600);
model.result.dataset('grid1').set('parmin3', -54.000000000000014);
model.result.dataset('grid1').set('parmax3', 108.00000000000003);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'grid1');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'esbe.V'});
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('colortable', 'Dipole');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').label('Electric Potential (esbe)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('expr', {'esbe.Ex' 'esbe.Ey' 'esbe.Ez'});
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('titletype', 'none');
model.result('pg1').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg1').feature('strmsl1').set('udist', '0.02');
model.result('pg1').feature('strmsl1').set('smooth', 'internal');
model.result('pg1').feature('strmsl1').set('maxlen', '0.4');
model.result('pg1').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg1').feature('strmsl1').set('inheritcolor', false);
model.result('pg1').feature('strmsl1').create('col1', 'Color');
model.result('pg1').feature('strmsl1').feature('col1').set('expr', {'esbe.V'});
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'esbe.V'});
model.result('pg1').feature('surf1').set('data', 'dset1');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('titletype', 'none');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('smooth', 'material');
model.result('pg1').feature('surf1').set('inheritplot', 'mslc1');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'1'});
model.result('pg1').feature('line1').set('data', 'dset1');
model.result('pg1').feature('line1').set('titletype', 'none');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').feature('line1').set('solutionparams', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'grid1');
model.result('pg2').create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('expr', {'esbe.normE'});
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', '-0.8');
model.result('pg2').feature('mslc1').set('smooth', 'internal');
model.result('pg2').label('Electric Field Norm (esbe)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('expr', {'esbe.Ex' 'esbe.Ey' 'esbe.Ez'});
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', '0.02');
model.result('pg2').feature('strmsl1').set('smooth', 'internal');
model.result('pg2').feature('strmsl1').set('maxlen', '0.4');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', {'esbe.normE'});
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', '-0.8');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'1'});
model.result('pg2').feature('line1').set('data', 'dset1');
model.result('pg2').feature('line1').set('titletype', 'none');
model.result('pg2').feature('line1').set('coloring', 'uniform');
model.result('pg2').feature('line1').set('color', 'black');
model.result('pg2').feature('line1').set('solutionparams', 'parent');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 320);
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 320);
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', -20);
model.result('pg1').run;
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 320);
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 320);
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', -20);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 350);
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 350);
model.result('pg2').run;
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 350);
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 350);
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'esbe.Q0_1'});
model.result.numerical('gev1').set('descr', {'Terminal charge'});
model.result.numerical('gev1').set('unit', {'C'});
model.result.numerical('gev1').setIndex('expr', 'esbe.Q0_1/esbe.V0_1', 0);
model.result.numerical('gev1').setIndex('unit', 'pF', 0);
model.result.numerical('gev1').setIndex('descr', 'Maxwell capacitance', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg1').run;

model.title('Tunable MEMS Capacitor');

model.description(['The electrostatically tunable parallel plate capacitor in this example is a typical component in various MEMS devices for radio frequencies that range between 300' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'MHz and 300' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'GHz. You can modify the distance between the two plates, as the applied voltage changes, through a spring attached to one of the plates. A postprocessing step then computes the capacitance.' newline  newline 'The example uses the Electrostatics, Boundary Elements interface, which is based on the boundary element method (BEM), for this simulation. This interface negates the need for defining a finite modeling domain and boundary as well as meshing the thin volume of the capacitor.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('capacitor_tunable.mph');

model.modelNode.label('Components');

out = model;
