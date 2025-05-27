function out = model
%
% electric_shielding.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electric_Currents');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ec', true);

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').feature('cyl1').set('r', 0.2);
model.geom('geom1').feature('cyl1').set('h', 0.2);
model.geom('geom1').feature('cyl1').set('pos', [0.4 0.5 0.5]);
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('cyl1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('del1', [1 2 3]);
model.geom('geom1').feature('sel1').label('Electrode');
model.geom('geom1').run('sel1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Titanium beta-21S');
model.material('mat1').set('family', 'titanium');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]' '0' '0' '0' '7.06e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '710[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '4940[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '105[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').selection.geom('geom1', 2);
model.material('mat1').selection.named('geom1_sel1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Sea Water');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'85'});

model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([3]);
model.physics('ec').create('pot1', 'ElectricPotential', 2);
model.physics('ec').feature('pot1').selection.set([4]);
model.physics('ec').feature('pot1').set('V0', 1);
model.physics('ec').create('term1', 'Terminal', 2);
model.physics('ec').feature('term1').selection.named('geom1_sel1');
model.physics('ec').create('es1', 'ElectricShielding', 2);
model.physics('ec').feature('es1').selection.named('geom1_sel1');
model.physics('ec').feature('es1').set('ds', '1[mm]');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'ec/es1'});
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
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').selection.geom('geom1', 2);
model.result.dataset('dset1').selection.named('geom1_sel1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Potential - Terminal');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('legendactive', true);
model.result('pg1').set('legendprecision', 4);
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'GrayScale');
model.result('pg1').run;
model.result('pg1').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ec', true);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'ec/term1'});
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.named('geom1_sel1');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Potential - Electric Shielding');
model.result('pg2').set('data', 'dset2');
model.result('pg2').run;

model.title('Electric Shielding');

model.description('This tutorial shows how to model isolated highly conductive objects using the Electric Currents interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('electric_shielding.mph');

model.modelNode.label('Components');

out = model;
