function out = model
%
% aln_lamb_wave_resonator_3d.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Piezoelectric_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('es', 'Electrostatics', 'geom1');
model.physics('es').model('comp1');
model.physics('es').create('ccnp1', 'ChargeConservationPiezo');
model.physics('es').feature('ccnp1').selection.all;
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('solid').feature('pzm1').selection.all;

model.multiphysics.create('pze1', 'PiezoelectricEffect', 'geom1', 3);
model.multiphysics('pze1').set('Solid_physics', 'solid');
model.multiphysics('pze1').set('Electrostatics_physics', 'es');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/es', true);
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);
model.study('std1').feature('eig').setSolveFor('/multiphysics/pze1', true);

model.common.create('mpf1', 'ParticipationFactors', 'comp1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

model.param.set('tp', '0.4[um]');
model.param.descr('tp', 'Thickness of piezoelectric layer');
model.param.set('l', '15[um]');
model.param.descr('l', 'Length of finger');
model.param.set('wf', '0.2[um]');
model.param.descr('wf', 'Width of finger');
model.param.set('op', '14.6[um]');
model.param.descr('op', 'Length of overlap, for op less than l');
model.param.set('dy', '(l-op)/2');
model.param.descr('dy', 'Electrode separation');
model.param.set('n', '11');
model.param.descr('n', 'Number of fingers, where (n+1)/4 = integer');
model.param.set('we', '0.2[um]');
model.param.descr('we', 'Width of edge');
model.param.set('la', '0.4[um]');
model.param.descr('la', 'Length of anchor');
model.param.set('Vapp', '1[V]');
model.param.descr('Vapp', 'Applied voltage');
model.param.set('eta0', '2.0e-3');
model.param.descr('eta0', 'Loss factor for electrode layer');
model.param.set('eta1', '2.0e-3');
model.param.descr('eta1', 'Loss factor for piezoelectric layer');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'wf' 'l'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' 'dy/2'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', {'(n+1)/4' '1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'4*wf' '0'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.create('mov1', 'Move');
model.geom('geom1').feature('wp1').geom.feature('mov1').selection('input').set({'arr1'});
model.geom('geom1').feature('wp1').geom.feature('mov1').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('mov1').set('displx', '2*wf');
model.geom('geom1').feature('wp1').geom.feature('mov1').set('disply', '-dy');
model.geom('geom1').feature('wp1').geom.run('mov1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'(n-1/2)*wf+we' '1'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('size', '2*wf', 1);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' '(l+dy)/2'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'2*we' 'la'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'(n-1/2)*wf-we' '0'});
model.geom('geom1').feature('wp1').geom.feature('r3').setIndex('pos', '(l+dy)/2+2*wf', 1);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'r2' 'r3'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('mir1').set('axis', [0 -1]);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', {'(n+1/2)*wf' 'l+dy'});
model.geom('geom1').feature('wp1').geom.feature('r4').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', {'(n+1/2)*wf/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('par1', 'Partition');
model.geom('geom1').feature('wp1').geom.feature('par1').selection('input').set({'arr1(1,1)'});
model.geom('geom1').feature('wp1').geom.feature('par1').selection('tool').set({'r4'});
model.geom('geom1').feature('wp1').geom.feature('par1').set('keeptool', true);
model.geom('geom1').feature('wp1').geom.run('par1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('par1', 1);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'tp', 0);
model.geom('geom1').run('ext1');

model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');

model.geom('geom1').run;

model.selection('box1').label('Signal');
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('ymin', '-l/2');
model.selection('box1').set('zmin', 'tp-0.01');
model.selection('box1').set('condition', 'inside');
model.selection.duplicate('box2', 'box1');
model.selection('box2').label('Ground');
model.selection('box2').set('ymin', -Inf);
model.selection('box2').set('ymax', 'l/2');
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Electrodes');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'box1' 'box2'});
model.selection.create('box3', 'Box');
model.selection('box3').model('comp1');
model.selection('box3').label('Symmetry');
model.selection('box3').set('entitydim', 2);
model.selection('box3').set('xmax', 0);
model.selection('box3').set('condition', 'inside');
model.selection.create('box4', 'Box');
model.selection('box4').model('comp1');
model.selection('box4').label('Top Surface');
model.selection('box4').set('entitydim', 2);
model.selection('box4').set('zmin', 'tp-0.01');
model.selection('box4').set('condition', 'inside');
model.selection.create('box5', 'Box');
model.selection('box5').model('comp1');
model.selection('box5').label('Device');
model.selection('box5').set('entitydim', 2);
model.selection('box5').set('ymin', '-((l+dy)/2+2*wf+la)+0.01');
model.selection('box5').set('ymax', '(l+dy)/2+2*wf+la-0.01');
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Fixed Constraints');
model.selection('com1').set('entitydim', 2);
model.selection('com1').set('input', {'box5'});

model.physics('es').create('term1', 'Terminal', 2);
model.physics('es').feature('term1').selection.named('box1');
model.physics('es').feature('term1').set('TerminalType', 'Voltage');
model.physics('es').feature('term1').set('V0', 'Vapp');
model.physics('es').create('gnd1', 'Ground', 2);
model.physics('es').feature('gnd1').selection.named('box2');
model.physics('es').create('symp1', 'SymmetryPlane', 2);
model.physics('es').feature('symp1').selection.named('box3');
model.physics('solid').feature('pzm1').create('mdmp1', 'MechanicalDamping', 3);
model.physics('solid').feature('pzm1').feature('mdmp1').set('DampingType', 'IsotropicLossFactor');
model.physics('solid').create('tl1', 'ThinLayer', 2);
model.physics('solid').feature('tl1').selection.named('uni1');
model.physics('solid').feature('tl1').set('lth', '80[nm]');
model.physics('solid').feature('tl1').feature('lemm1').create('dmp1', 'Damping', 2);
model.physics('solid').feature('tl1').feature('lemm1').feature('dmp1').set('DampingType', 'IsotropicLossFactor');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('com1');
model.physics('solid').create('sym1', 'SymmetrySolid', 2);
model.physics('solid').feature('sym1').selection.named('box3');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Pt - Platinum');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('electricconductivity', {'8.9e6[S/m]' '0' '0' '0' '8.9e6[S/m]' '0' '0' '0' '8.9e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'8.80e-6[1/K]' '0' '0' '0' '8.80e-6[1/K]' '0' '0' '0' '8.80e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '133[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('density', '21450[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'71.6[W/(m*K)]' '0' '0' '0' '71.6[W/(m*K)]' '0' '0' '0' '71.6[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '168e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.38');
model.material('mat1').selection.geom('geom1', 2);
model.material('mat1').selection.named('uni1');
model.material('mat1').propertyGroup('def').set('lossfactor', {'eta0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat2').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat2').label('Aluminum Nitride');
model.material('mat2').set('family', 'custom');
model.material('mat2').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat2').set('customdiffuse', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat2').set('noise', true);
model.material('mat2').set('fresnel', 0.9);
model.material('mat2').set('roughness', 0.1);
model.material('mat2').set('metallic', 0);
model.material('mat2').set('pearl', 0);
model.material('mat2').set('diffusewrap', 0);
model.material('mat2').set('clearcoat', 0);
model.material('mat2').set('reflectance', 0);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'9' '0' '0' '0' '9' '0' '0' '0' '9'});
model.material('mat2').propertyGroup('def').set('density', '3300[kg/m^3]');
model.material('mat2').propertyGroup('StrainCharge').set('sE', {'2.8987e-12[1/Pa]' '-9.326e-013[1/Pa]' '-5.0038e-013[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-9.326e-013[1/Pa]' '2.8987e-12[1/Pa]' '-5.0038e-013[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-5.0038e-013[1/Pa]' '-5.0038e-013[1/Pa]' '2.8253e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '8E-12[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '8E-12[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '7.6628E-12[1/Pa]'});
model.material('mat2').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '0[C/N]' '-1.9159e-012[C/N]' '0[C/N]' '0[C/N]' '-1.9159e-012[C/N]' '0[C/N]' '0[C/N]' '4.9597e-012[C/N]' '0[C/N]'  ...
'-3.84e-012[C/N]' '0[C/N]' '-3.84e-012[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat2').propertyGroup('StrainCharge').set('epsilonrT', {'9.2081' '0' '0' '0' '9.2081' '0' '0' '0' '10.1192'});
model.material('mat2').propertyGroup('StressCharge').set('cE', {'4.1e+011[Pa]' '1.49e+011[Pa]' '0.99e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.49e+011[Pa]' '4.1e+011[Pa]' '0.99e+011[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0.99e+011[Pa]' '0.99e+011[Pa]' '3.89e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]'  ...
'0[Pa]' '1.25e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.25e+011[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '1.305e+011[Pa]'});
model.material('mat2').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '0[C/m^2]' '-0.58[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-0.58[C/m^2]' '0[C/m^2]' '0[C/m^2]' '1.55[C/m^2]' '0[C/m^2]'  ...
'-0.48[C/m^2]' '0[C/m^2]' '-0.48[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat2').propertyGroup('StressCharge').set('epsilonrS', {'9' '0' '0' '0' '9' '0' '0' '0' '9'});
model.material('mat2').selection.all;
model.material('mat2').propertyGroup('def').set('lossfactor', {'eta1'});

model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.named('box4');
model.mesh('mesh1').feature('fq1').create('size1', 'Size');
model.mesh('mesh1').feature('fq1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmax', 0.1);
model.mesh('mesh1').run('fq1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 3);
model.mesh('mesh1').run('swe1');

model.study('std1').label('Eigenfrequency');
model.study('std1').setGenPlots(false);
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 20);
model.study('std1').feature('eig').set('eigunit', 'GHz');
model.study('std1').feature('eig').set('shift', '8');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '1.7E-11');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('mir1', 'Mirror3D');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Mode Shape');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('looplevel', [3]);
model.result('pg1').set('edges', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'w');
model.result('pg1').feature('surf1').set('descractive', true);
model.result('pg1').run;
model.result('pg1').set('showlegends', false);

model.view('view3').set('showgrid', false);
model.view('view3').set('showaxisorientation', false);

model.result('pg1').run;
model.result('pg1').set('titletype', 'none');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Mode Shape, Center XZ Plane');
model.result('pg2').set('data', 'mir1');
model.result('pg2').set('looplevel', [3]);
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('expr', 'solid.disp');
model.result('pg2').feature('slc1').set('descractive', true);
model.result('pg2').feature('slc1').set('quickplane', 'zx');
model.result('pg2').feature('slc1').set('quickynumber', 1);
model.result('pg2').feature('slc1').set('colortabletype', 'discrete');
model.result('pg2').feature('slc1').set('bandcount', 15);
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/es', true);
model.study('std2').feature('freq').setSolveFor('/physics/solid', true);
model.study('std2').feature('freq').setSolveFor('/multiphysics/pze1', true);
model.study('std2').label('Frequency Domain - 7.95 to 8.05 GHz');
model.study('std2').setGenPlots(false);
model.study('std2').feature('freq').set('punit', 'GHz');
model.study('std2').feature('freq').set('plist', 'range(7.95,0.005,8.05)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'range(7.95,0.005,8.05)'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'GHz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (pze1) (Merged)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (pze1)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Frequency Domain');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Log10(Abs(Y11))');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'log10(abs(es.Y11))', 0);
model.result('pg3').feature('glob1').set('autodescr', false);
model.result('pg3').feature('glob1').create('gmrk1', 'GraphMarker');
model.result('pg3').feature('glob1').feature('gmrk1').set('linewidth', 'preference');
model.result('pg3').run;
model.result('pg3').feature('glob1').feature('gmrk1').set('inclxcoord', true);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmin', 7.938);
model.result('pg3').set('xmax', 8.082);
model.result('pg3').set('ymin', -4.5);
model.result('pg3').set('ymax', '-3.0');
model.result('pg3').run;

model.title(['Aluminum Nitride Lamb Wave Resonator ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' 3D']);

model.description('Lamb wave resonators are useful components for many radio-frequency applications. This tutorial shows how to model an aluminum nitride lamb wave resonator and perform eigenfrequency and frequency-response analyses to characterize the device.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('aln_lamb_wave_resonator_3d.mph');

model.modelNode.label('Components');

out = model;
