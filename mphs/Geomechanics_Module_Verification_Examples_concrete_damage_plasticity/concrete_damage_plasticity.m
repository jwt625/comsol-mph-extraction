function out = model
%
% concrete_damage_plasticity.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').run;

model.physics('solid').feature('lemm1').create('cm1', 'Concrete', 3);
model.physics('solid').feature('lemm1').feature('cm1').set('materialModel', 'coupledDamagePlasticity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Concrete');
model.material('mat1').set('family', 'concrete');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'10e-6[1/K]' '0' '0' '0' '10e-6[1/K]' '0' '0' '0' '10e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2300[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]' '0' '0' '0' '1.8[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '880[J/(kg*K)]');
model.material('mat1').propertyGroup('Enu').set('E', '25[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.20');
model.material('mat1').propertyGroup.create('YieldStressParameters', 'Yield_stress_parameters');
model.material('mat1').propertyGroup('YieldStressParameters').set('sigmaut', {'2[MPa]'});
model.material('mat1').propertyGroup('YieldStressParameters').set('sigmauc', {'20[MPa]'});
model.material('mat1').propertyGroup.create('FractureParameters', 'Fracture_parameters');
model.material('mat1').propertyGroup('FractureParameters').set('Gft', {'100[J/m^2]'});

model.physics('solid').create('tm1', 'TestMaterial', -1);
model.physics('solid').feature('tm1').label('Monotonic Tests');
model.physics('solid').feature('tm1').selection('domainSelection').set([1]);
model.physics('solid').feature('tm1').set('testSpecimenSize', 'Userdef');
model.physics('solid').feature('tm1').set('charL', '0.1[m]');
model.physics('solid').feature('tm1').set('lambda1_min', '1-5e-3');
model.physics('solid').feature('tm1').set('lambda1_max', '1+1e-3');
model.physics('solid').feature('tm1').set('biaxialTest', true);
model.physics('solid').feature('tm1').set('lambda2_min', '1-5e-3');
model.physics('solid').feature('tm1').set('lambda2_max', 1);
model.physics('solid').feature('tm1').set('biaxiality_ratio', 0.5);
model.physics('solid').feature('tm1').set('isotropicTest', true);
model.physics('solid').feature('tm1').set('lambda4_min', '1-1e-2');
model.physics('solid').feature('tm1').runCommand('setupTests');

model.result('solidtm1utpg1').run;
model.result('solidtm1utpg1').run;
model.result('solidtm1utpg1').feature('ptgr1').set('unit', 'MPa');
model.result('solidtm1utpg1').run;
model.result('solidtm1utpg1').feature('ptgr2').set('unit', 'MPa');
model.result('solidtm1utpg1').run;
model.result('solidtm1btpg1').run;
model.result('solidtm1btpg1').feature('ptgr1').set('unit', 'MPa');
model.result('solidtm1btpg1').feature('ptgr1').set('legend', true);
model.result('solidtm1btpg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('solidtm1btpg1').feature('ptgr1').setIndex('legends', 'Longitudinal strain', 0);
model.result('solidtm1btpg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('solidtm1btpg1').run;
model.result('solidtm1btpg1').feature('ptgr2').set('xdataexpr', 'solid1.elogyy');
model.result('solidtm1btpg1').feature('ptgr2').setIndex('legends', 'Transverse strain', 0);
model.result('solidtm1btpg1').feature.duplicate('ptgr3', 'ptgr2');
model.result('solidtm1btpg1').run;
model.result('solidtm1btpg1').feature('ptgr3').set('xdataexpr', 'solid1.elogzz');
model.result('solidtm1btpg1').feature('ptgr3').setIndex('legends', 'Out-of-plane strain', 0);
model.result('solidtm1btpg1').run;
model.result('solidtm1btpg1').label('True Longitudinal Stress (Biaxial Test)');
model.result('solidtm1btpg1').set('xlabelactive', true);
model.result('solidtm1btpg1').set('xlabel', 'Strain (1)');
model.result('solidtm1btpg1').run;
model.result('solidtm1itpg1').run;
model.result('solidtm1itpg1').run;
model.result('solidtm1itpg1').feature('ptgr1').set('unit', 'MPa');
model.result('solidtm1itpg1').run;

model.func.create('int1', 'Interpolation');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', '2e-4', 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', '-1.6e-3', 2, 1);
model.func('int1').setIndex('table', 3, 3, 0);
model.func('int1').setIndex('table', 0, 3, 1);

model.physics('solid').create('tm2', 'TestMaterial', -1);
model.physics('solid').feature('tm2').label('Cyclic Test 1');
model.physics('solid').feature('tm2').selection('domainSelection').set([1]);
model.physics('solid').feature('tm2').set('testSpecimenSize', 'Userdef');
model.physics('solid').feature('tm2').set('charL', '0.1[m]');
model.physics('solid').feature('tm2').set('testSetup', 'userDefined');
model.physics('solid').feature('tm2').set('para_max', 3);
model.physics('solid').feature('tm2').set('stepN', 300);
model.physics('solid').feature('tm2').set('stretchFunction1', '1+int1(para)');
model.physics('solid').feature('tm2').runCommand('setupTests');

model.result('solidtm1utpg1').run;
model.result('solidtm2utpg1').run;
model.result('solidtm2utpg1').feature.copy('ptgr2', 'solidtm1utpg1/ptgr1');
model.result('solidtm2utpg1').feature.copy('ptgr3', 'solidtm1utpg1/ptgr2');
model.result('solidtm2utpg1').run;
model.result('solidtm2utpg1').feature('ptgr2').set('linestyle', 'dotted');
model.result('solidtm2utpg1').feature('ptgr2').set('linecolor', 'black');
model.result('solidtm2utpg1').run;
model.result('solidtm2utpg1').feature('ptgr3').set('linestyle', 'dotted');
model.result('solidtm2utpg1').feature('ptgr3').set('linecolor', 'black');
model.result('solidtm2utpg1').run;
model.result('solidtm2utpg1').feature('ptgr1').set('unit', 'MPa');
model.result('solidtm2utpg1').feature('ptgr1').set('linewidth', 2);
model.result('solidtm2utpg1').run;

model.func.create('int2', 'Interpolation');
model.func('int2').setIndex('table', 0, 0, 0);
model.func('int2').setIndex('table', 0, 0, 1);
model.func('int2').setIndex('table', 1, 1, 0);
model.func('int2').setIndex('table', '-1.5e-3', 1, 1);
model.func('int2').setIndex('table', 2, 2, 0);
model.func('int2').setIndex('table', '1e-3', 2, 1);

model.physics('solid').create('tm3', 'TestMaterial', -1);
model.physics('solid').feature('tm3').label('Cyclic Test 2');
model.physics('solid').feature('tm3').selection('domainSelection').set([1]);
model.physics('solid').feature('tm3').set('testSpecimenSize', 'Userdef');
model.physics('solid').feature('tm3').set('charL', '0.1[m]');
model.physics('solid').feature('tm3').set('testSetup', 'userDefined');
model.physics('solid').feature('tm3').set('para_max', 2);
model.physics('solid').feature('tm3').set('stepN', 200);
model.physics('solid').feature('tm3').set('stretchFunction1', '1+int2(para)');
model.physics('solid').feature('tm3').runCommand('setupTests');

model.result('solidtm2utpg1').run;
model.result('solidtm3utpg1').run;
model.result('solidtm3utpg1').feature.copy('ptgr2', 'solidtm2utpg1/ptgr2');
model.result('solidtm3utpg1').feature.copy('ptgr3', 'solidtm2utpg1/ptgr3');
model.result('solidtm3utpg1').run;
model.result('solidtm3utpg1').run;
model.result('solidtm3utpg1').feature('ptgr1').set('unit', 'MPa');
model.result('solidtm3utpg1').feature('ptgr1').set('linewidth', 2);
model.result('solidtm3utpg1').run;
model.result('solidtm3utpg1').run;
model.result('solidtm3utpg1').set('xlabelactive', true);
model.result('solidtm3utpg1').set('ylabelactive', true);
model.result('solidtm3utpg1').set('ylabel', 'Stress (MPa)');
model.result('solidtm3utpg1').set('xlabel', 'Strain (1)');
model.result('solidtm3utpg1').set('xlabelactive', false);
model.result('solidtm3utpg1').set('ylabelactive', false);

model.title(['Concrete Damage' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Plasticity Material Tests']);

model.description('This example shows the behavior of the coupled damage-plasticity model for concrete when subjected to different loading conditions.');

model.mesh.clearMeshes;

model.sol('solidtm1sol').clearSolutionData;
model.sol('solidtm1sol1').clearSolutionData;
model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('solidtm2sol').clearSolutionData;
model.sol('solidtm2sol1').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('solidtm3sol').clearSolutionData;
model.sol('solidtm3sol1').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('concrete_damage_plasticity.mph');

model.modelNode.label('Components');

out = model;
