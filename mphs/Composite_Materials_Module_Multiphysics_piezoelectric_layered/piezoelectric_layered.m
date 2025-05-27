function out = model
%
% piezoelectric_layered.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Composite_Materials_Module/Multiphysics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('lshell', 'LayeredShell', 'geom1');
model.physics('lshell').model('comp1');
model.physics('lshell').create('pzm1', 'PiezoelectricMaterialModel');
model.physics('lshell').feature('pzm1').selection.all;
model.physics.create('ecis', 'ElectricCurrentsShell', 'geom1');
model.physics('ecis').model('comp1');
model.physics('ecis').prop('DefaultDescription').set('DefaultDescription', 'Electric_currents_in_layered_shells');
model.physics('ecis').prop('LayerSelection').set('lth_mat', 'from_mat');
model.physics('ecis').create('epzml1', 'PiezoelectricLayer');
model.physics('ecis').feature('epzml1').selection.all;

model.multiphysics.create('pzel1', 'PiezoelectricEffectLS', 'geom1', 2);
model.multiphysics('pzel1').set('Solid_physics', 'lshell');
model.multiphysics('pzel1').set('Electrostatics_physics', 'ecis');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/lshell', true);
model.study('std1').feature('stat').setSolveFor('/physics/ecis', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/pzel1', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [50 30]);
model.geom('geom1').run('fin');
model.geom('geom1').run('wp1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'wp1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 2 1]);
model.geom('geom1').feature('arr1').set('displ', [0 50 0]);
model.geom('geom1').run('arr1');

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').label('Aluminum');
model.material('mat1').set('family', 'aluminum');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat1').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.33');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material.create('mat2', 'Common', '');
model.material('mat2').propertyGroup.create('StrainCharge', 'Strain-charge form');
model.material('mat2').propertyGroup.create('StressCharge', 'Stress-charge form');
model.material('mat2').label('Lead Zirconate Titanate (PZT-5H)');
model.material('mat2').set('family', 'lead');
model.material('mat2').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1.3[W/(m*K)]' '0' '0' '0' '1.3[W/(m*K)]' '0' '0' '0' '1.3[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material('mat2').propertyGroup('def').set('density', '7500[kg/m^3]');
model.material('mat2').propertyGroup('StrainCharge').set('sE', {'1.65e-011[1/Pa]' '-4.78e-012[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '-4.78e-012[1/Pa]' '1.65e-011[1/Pa]' '-8.45e-012[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '-8.45e-012[1/Pa]' '-8.45e-012[1/Pa]' '2.07e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.35e-011[1/Pa]' '0[1/Pa]'  ...
'0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '0[1/Pa]' '4.26e-011[1/Pa]'});
model.material('mat2').propertyGroup('StrainCharge').set('dET', {'0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '-2.74e-010[C/N]' '0[C/N]' '0[C/N]' '5.93e-010[C/N]' '0[C/N]'  ...
'7.41e-010[C/N]' '0[C/N]' '7.41e-010[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]' '0[C/N]'});
model.material('mat2').propertyGroup('StrainCharge').set('epsilonrT', {'3130' '0' '0' '0' '3130' '0' '0' '0' '3400'});
model.material('mat2').propertyGroup('StressCharge').set('cE', {'1.27205e+011[Pa]' '8.02122e+010[Pa]' '8.46702e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '8.02122e+010[Pa]' '1.27205e+011[Pa]' '8.46702e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '8.46702e+010[Pa]' '8.46702e+010[Pa]' '1.17436e+011[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]'  ...
'0[Pa]' '2.29885e+010[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.29885e+010[Pa]' '0[Pa]'  ...
'0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '0[Pa]' '2.34742e+010[Pa]'});
model.material('mat2').propertyGroup('StressCharge').set('eES', {'0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '-6.62281[C/m^2]' '0[C/m^2]' '0[C/m^2]' '23.2403[C/m^2]' '0[C/m^2]'  ...
'17.0345[C/m^2]' '0[C/m^2]' '17.0345[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]' '0[C/m^2]'});
model.material('mat2').propertyGroup('StressCharge').set('epsilonrS', {'1704.4' '0' '0' '0' '1704.4' '0' '0' '0' '1433.6'});
model.material.create('lmat1', 'LayeredMaterial', '');
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', '1e-4[m]', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 2', 1);
model.material('lmat1').setIndex('link', 'mat1', 1);
model.material('lmat1').setIndex('rotation', '0.0', 1);
model.material('lmat1').setIndex('thickness', '1e-4[m]', 1);
model.material('lmat1').setIndex('meshPoints', 2, 1);
model.material('lmat1').setIndex('tag', 'lmat1_2', 1);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', '0.0', 2);
model.material('lmat1').setIndex('thickness', '1e-4[m]', 2);
model.material('lmat1').setIndex('meshPoints', 2, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('layername', 'Layer 3', 2);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('rotation', '0.0', 2);
model.material('lmat1').setIndex('thickness', '1e-4[m]', 2);
model.material('lmat1').setIndex('meshPoints', 2, 2);
model.material('lmat1').setIndex('tag', 'lmat1_3', 2);
model.material('lmat1').setIndex('thickness', '1[mm]', 0);
model.material('lmat1').setIndex('link', 'mat2', 1);
model.material('lmat1').setIndex('thickness', '4[mm]', 1);
model.material('lmat1').setIndex('meshPoints', 4, 1);
model.material('lmat1').setIndex('link', 'mat1', 2);
model.material('lmat1').setIndex('thickness', '1[mm]', 2);
model.material('lmat1').setIndex('meshPoints', 2, 2);
model.material('lmat1').set('widthRatio', '8/30');

model.geom('geom1').run;

model.material.create('llmat1', 'LayeredMaterialLink', 'comp1');

model.physics('ecis').feature('epzml1').set('allLayers', false);
model.physics('ecis').feature('epzml1').setIndex('shelllist_lCheck', 0, 0, 0);
model.physics('ecis').feature('epzml1').setIndex('shelllist_lCheck', 0, 2, 0);
model.physics('lshell').feature('pzm1').label('Piezoelectric Material (Z Pole Axis)');
model.physics('lshell').feature('pzm1').selection.set([1]);
model.physics('lshell').feature('pzm1').set('allLayers', false);
model.physics('lshell').feature('pzm1').setIndex('shelllist_lCheck', 0, 0, 0);
model.physics('lshell').feature('pzm1').setIndex('shelllist_lCheck', 0, 2, 0);
model.physics('lshell').feature('pzm1').set('ConstitutiveRelation', 'StrainCharge');
model.physics('lshell').feature.duplicate('pzm2', 'pzm1');
model.physics('lshell').feature('pzm2').label('Piezoelectric Material (X Pole Axis)');
model.physics('lshell').feature('pzm2').selection.set([2]);
model.physics('lshell').feature('pzm2').set('Flip', 'Flipn_t1');
model.physics('lshell').prop('LayerSelection').set('bndType', 'allShell');
model.physics('lshell').create('fix1', 'Fixed', 1);
model.physics('lshell').feature('fix1').selection.set([1 4]);
model.physics('ecis').feature('csh1').create('gnd1', 'Ground', 2);
model.physics('ecis').feature('csh1').create('pot1', 'ElectricPotential', 2);
model.physics('ecis').feature('csh1').feature('pot1').set('applyTo', 'bottom');
model.physics('ecis').feature('csh1').feature('pot1').set('V0', 20);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').run;

model.geom('geom1').feature('arr1').active(false);
model.geom('geom1').run;

model.mesh('mesh1').run;

model.geom('geom1').feature('arr1').active(true);
model.geom('geom1').run;

model.mesh('mesh1').run;

model.physics('lshell').feature('pzm1').selection.set([1]);
model.physics('lshell').feature('pzm2').selection.set([2]);

model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('rhob', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('lshl1', 'LayeredMaterial');
model.result.dataset('lshl1').selection.geom('geom1', 2);
model.result.dataset('lshl1').selection.set([1]);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Electric Potential');
model.result('pg1').set('data', 'lshl1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'V');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Vertical Displacement (Z Pole Axis)');
model.result('pg2').set('data', 'lshl1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'w');
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').run;
model.result.dataset.duplicate('lshl2', 'lshl1');
model.result.dataset('lshl2').selection.set([2]);
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Vertical Displacement (X Pole Axis)');
model.result('pg3').set('data', 'lshl2');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('colorlegend', false);
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('colortable', 'GrayScale');
model.result('pg1').feature('surf1').set('titletype', 'none');
model.result('pg1').run;

model.view('view1').set('scenelight', true);

model.result('pg1').feature('surf1').set('expr', 'V');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').feature('surf1').set('titletype', 'auto');
model.result('pg1').feature('surf1').set('colorlegend', true);
model.result('pg1').run;
model.result('pg2').run;

model.title('Piezoelectricity in a Layered Shell');

model.description('This is a tutorial example showing how to model piezoelectric devices using the layered shell functionality. Two cases of material orientation are studied. In the first case, the pole axis is normal to the shell surface, which results in a thickness change. In the second case, the pole axis is in the plane of the shell, which leads to bending.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('piezoelectric_layered.mph');

model.modelNode.label('Components');

out = model;
