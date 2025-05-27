function out = model
%
% metasurface_beam_deflector.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Gratings_and_Metamaterials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewfd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lda0', '1.55[um]', 'Design wavelength');
model.param.set('px', '500[nm]', 'Unit cell spacing in x');
model.param.set('py', '500[nm]', 'Unit cell spacing in y');
model.param.set('tSub', 'extraSpace/nSiO2', 'Thickness of substrate');
model.param.set('tPost', '1[um]', 'Thickness of posts');
model.param.set('tAir', 'tPost+extraSpace', 'Thickness of air');
model.param.set('extraSpace', 'lda0/2', 'Ensure there is sufficient space above/below the posts');
model.param.set('nSiO2', '1.444', 'Index of the substrate at the design wavelength');
model.param.set('N', '6', 'Number of unit cells');
model.param.set('d', 'N*px', 'Structure size in x');
model.param.set('x1', '(0 + 1/2)*px', 'Location of post 1');
model.param.set('x2', '(1 + 1/2)*px', 'Location of post 2');
model.param.set('x3', '(2 + 1/2)*px', 'Location of post 3');
model.param.set('x4', '(3 + 1/2)*px', 'Location of post 4');
model.param.set('x5', '(4 + 1/2)*px', 'Location of post 5');
model.param.set('x6', '(5 + 1/2)*px', 'Location of post 6');
model.param.set('r1', '90[nm]', 'Radius of post 1');
model.param.set('r2', '130[nm]', 'Radius of post 2');
model.param.set('r3', '150[nm]', 'Radius of post 3');
model.param.set('r4', '165[nm]', 'Radius of post 4');
model.param.set('r5', '180[nm]', 'Radius of post 5');
model.param.set('r6', '195[nm]', 'Radius of post 6');
model.param.set('theta', 'asin(lda0/d)/1[deg]', 'Deflection angle');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('Substrate');
model.geom('geom1').feature('blk1').set('size', {'d' 'py' 'tSub'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-tSub'});
model.geom('geom1').feature('blk1').set('selresult', true);
model.geom('geom1').run('blk1');
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').label('Air Block');
model.geom('geom1').feature('blk2').set('size', {'d' 'py' 'tAir'});
model.geom('geom1').feature('blk2').set('pos', [0 0 0]);
model.geom('geom1').feature('blk2').set('selresultshow', false);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run('fin');
model.geom('geom1').run('blk2');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').label('Post 1');
model.geom('geom1').feature('cyl1').set('r', 'r1');
model.geom('geom1').feature('cyl1').set('h', 'tPost');
model.geom('geom1').feature('cyl1').set('pos', {'x1' 'py/2' '0'});
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Posts');
model.geom('geom1').feature('cyl1').set('contributeto', 'csel1');
model.geom('geom1').run('cyl1');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').label('Post 2');
model.geom('geom1').feature('cyl2').set('r', 'r2');
model.geom('geom1').feature('cyl2').set('pos', {'x2' 'py/2' '0'});
model.geom('geom1').run('cyl2');
model.geom('geom1').feature.duplicate('cyl3', 'cyl2');
model.geom('geom1').feature('cyl3').label('Post 3');
model.geom('geom1').feature('cyl3').set('r', 'r3');
model.geom('geom1').feature('cyl3').set('pos', {'x3' 'py/2' '0'});
model.geom('geom1').run('cyl3');
model.geom('geom1').feature.duplicate('cyl4', 'cyl3');
model.geom('geom1').feature('cyl4').label('Post 4');
model.geom('geom1').feature('cyl4').set('r', 'r4');
model.geom('geom1').feature('cyl4').set('pos', {'x4' 'py/2' '0'});
model.geom('geom1').run('cyl4');
model.geom('geom1').feature.duplicate('cyl5', 'cyl4');
model.geom('geom1').feature('cyl5').label('Post 5');
model.geom('geom1').feature('cyl5').set('r', 'r5');
model.geom('geom1').feature('cyl5').set('pos', {'x5' 'py/2' '0'});
model.geom('geom1').run('cyl5');
model.geom('geom1').feature.duplicate('cyl6', 'cyl5');
model.geom('geom1').feature('cyl6').label('Post 6');
model.geom('geom1').feature('cyl6').set('r', 'r6');
model.geom('geom1').feature('cyl6').set('pos', {'x6' 'py/2' '0'});
model.geom('geom1').run('cyl6');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Air');
model.geom('geom1').feature('difsel1').set('add', {'blk2'});
model.geom('geom1').feature('difsel1').set('subtract', {'csel1'});
model.geom('geom1').feature.move('difsel1', 9);
model.geom('geom1').run('difsel1');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup('RefractiveIndex').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('RefractiveIndex').func.create('int2', 'Interpolation');
model.material('mat1').label('Si (Silicon) (Pierce and Spicer 1972: a-Si; n,k 0.0103-2.07 um)');
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('funcname', 'nr');
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('table', {'1.033E-1' '3.27E-1';  ...
'1.078E-1' '3.63E-1';  ...
'1.127E-1' '3.92E-1';  ...
'1.181E-1' '4.23E-1';  ...
'1.240E-1' '4.59E-1';  ...
'1.305E-1' '4.97E-1';  ...
'1.378E-1' '5.43E-1';  ...
'1.459E-1' '5.97E-1';  ...
'1.550E-1' '6.60E-1';  ...
'1.653E-1' '7.35E-1';  ...
'1.771E-1' '8.32E-1';  ...
'1.907E-1' '9.51E-1';  ...
'2.066E-1' '1.11E+0';  ...
'2.254E-1' '1.35E+0';  ...
'2.480E-1' '1.69E+0';  ...
'2.583E-1' '1.86E+0';  ...
'2.695E-1' '2.07E+0';  ...
'2.818E-1' '2.30E+0';  ...
'2.952E-1' '2.56E+0';  ...
'3.100E-1' '2.87E+0';  ...
'3.263E-1' '3.21E+0';  ...
'3.444E-1' '3.55E+0';  ...
'3.543E-1' '3.73E+0';  ...
'3.647E-1' '3.90E+0';  ...
'3.875E-1' '4.17E+0';  ...
'4.133E-1' '4.38E+0';  ...
'4.428E-1' '4.47E+0';  ...
'4.769E-1' '4.49E+0';  ...
'4.960E-1' '4.47E+0';  ...
'5.166E-1' '4.46E+0';  ...
'5.636E-1' '4.36E+0';  ...
'6.199E-1' '4.23E+0';  ...
'6.526E-1' '4.17E+0';  ...
'6.888E-1' '4.09E+0';  ...
'7.293E-1' '4.01E+0';  ...
'7.749E-1' '3.93E+0';  ...
'8.266E-1' '3.86E+0';  ...
'8.856E-1' '3.77E+0';  ...
'9.538E-1' '3.68E+0';  ...
'1.033E+0' '3.61E+0';  ...
'1.127E+0' '3.57E+0';  ...
'1.240E+0' '3.54E+0';  ...
'1.378E+0' '3.50E+0';  ...
'1.550E+0' '3.48E+0';  ...
'1.771E+0' '3.45E+0';  ...
'2.066E+0' '3.44E+0'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int1').set('argunit', {'um'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('funcname', 'ni');
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('table', {'1.033E-1' '7.26E-1';  ...
'1.078E-1' '8.47E-1';  ...
'1.127E-1' '9.46E-1';  ...
'1.181E-1' '1.04E+0';  ...
'1.240E-1' '1.14E+0';  ...
'1.305E-1' '1.24E+0';  ...
'1.378E-1' '1.35E+0';  ...
'1.459E-1' '1.47E+0';  ...
'1.550E-1' '1.60E+0';  ...
'1.653E-1' '1.74E+0';  ...
'1.771E-1' '1.89E+0';  ...
'1.907E-1' '2.07E+0';  ...
'2.066E-1' '2.28E+0';  ...
'2.254E-1' '2.51E+0';  ...
'2.480E-1' '2.76E+0';  ...
'2.583E-1' '2.85E+0';  ...
'2.695E-1' '2.93E+0';  ...
'2.818E-1' '2.99E+0';  ...
'2.952E-1' '3.04E+0';  ...
'3.100E-1' '3.06E+0';  ...
'3.263E-1' '3.00E+0';  ...
'3.444E-1' '2.88E+0';  ...
'3.543E-1' '2.79E+0';  ...
'3.647E-1' '2.66E+0';  ...
'3.875E-1' '2.38E+0';  ...
'4.133E-1' '2.02E+0';  ...
'4.428E-1' '1.64E+0';  ...
'4.769E-1' '1.28E+0';  ...
'4.960E-1' '1.12E+0';  ...
'5.166E-1' '9.69E-1';  ...
'5.636E-1' '6.90E-1';  ...
'6.199E-1' '4.61E-1';  ...
'6.526E-1' '3.63E-1';  ...
'6.888E-1' '2.71E-1';  ...
'7.293E-1' '1.99E-1';  ...
'7.749E-1' '1.36E-1';  ...
'8.266E-1' '8.12E-2';  ...
'8.856E-1' '4.01E-2';  ...
'9.538E-1' '0.00E+0';  ...
'1.033E+0' '0.00E+0';  ...
'1.127E+0' '0.00E+0';  ...
'1.240E+0' '0.00E+0';  ...
'1.378E+0' '0.00E+0';  ...
'1.550E+0' '0.00E+0';  ...
'1.771E+0' '0.00E+0';  ...
'2.066E+0' '0.00E+0'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('RefractiveIndex').func('int2').set('argunit', {'um'});
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)' '0' '0' '0' 'nr(c_const/freq)'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)' '0' '0' '0' 'ni(c_const/freq)'});
model.material('mat1').propertyGroup('RefractiveIndex').addInput('frequency');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').label('SiO2 (Silicon dioxide, Silica, Quartz) (Malitson 1965: Fused silica; n 0.21-6.7 um)');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'0.6961663' '0.4079426' '0.8974794' '0.00467914825849' '0.013512063073959999' '97.93400253792099'});
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '0');
model.material('mat2').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat2').propertyGroup('RefractiveIndex').addInput('frequency');
model.material('mat2').selection.named('geom1_blk1_dom');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Air');
model.material('mat3').selection.named('geom1_difsel1');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'1'});

model.physics('ewfd').create('port1', 'Port', 2);
model.physics('ewfd').feature('port1').selection.set([3]);
model.physics('ewfd').feature('port1').set('PortType', 'Periodic');
model.physics('ewfd').feature('port1').set('Eampl', [0 1 0]);
model.physics('ewfd').feature('port1').set('n', {'nSiO2' '0' '0' '0' 'nSiO2' '0' '0' '0' 'nSiO2'});
model.physics('ewfd').create('port2', 'Port', 2);
model.physics('ewfd').feature('port2').selection.set([7]);
model.physics('ewfd').feature('port2').set('PortType', 'Periodic');
model.physics('ewfd').feature('port2').set('Eampl', [0 1 0]);
model.physics('ewfd').create('pc1', 'PeriodicCondition', 2);
model.physics('ewfd').feature('pc1').selection.set([1 4 46 47]);
model.physics('ewfd').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('ewfd').feature('pc1').set('Floquet_source', 'FromPeriodicPort');
model.physics('ewfd').feature.duplicate('pc2', 'pc1');
model.physics('ewfd').feature('pc2').selection.set([2 5 8 9]);

model.study('std1').feature('wave').set('plist', 'lda0');

model.physics('ewfd').feature('port1').runCommand('addDiffractionOrders');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'lambda0'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'lda0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'wave');
model.sol('sol1').feature('s1').set('control', 'wave');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (ewfd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankasolv', {'stored'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankarelax', 0.95);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Reflectance, Transmittance, and Absorptance (ewfd)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'ewfd.Rorder_0_0' 'ewfd.Rorder_0_n2_ip' 'ewfd.Rorder_0_n2_op' 'ewfd.Rorder_0_n1_ip' 'ewfd.Rorder_0_n1_op' 'ewfd.Rorder_0_0_orth' 'ewfd.Rorder_0_p1_ip' 'ewfd.Rorder_0_p1_op' 'ewfd.Rorder_0_p2_ip' 'ewfd.Rorder_0_p2_op'  ...
'ewfd.Rtotal' 'ewfd.Torder_0_0' 'ewfd.Torder_n1_0_ip' 'ewfd.Torder_n1_0_op' 'ewfd.Torder_0_0_orth' 'ewfd.Torder_p1_0_ip' 'ewfd.Torder_p1_0_op' 'ewfd.Ttotal' 'ewfd.RTtotal' 'ewfd.Atotal'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').label('Polarization Plot (ewfd)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Polarization states, Color: Phase (Radians)');
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', '1', 0);
model.result('pg2').create('plz1', 'Polarization');
model.result('pg2').feature('plz1').set('linestyle', 'solid');
model.result('pg2').feature('plz1').set('linewidth', 2);
model.result('pg2').feature('plz1').set('display', '2');
model.result('pg2').feature('plz1').create('col1', 'Color');
model.result('pg2').feature('plz1').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz1').feature('col1').set('colorlegend', true);
model.result('pg2').feature('plz1').set('legend', true);
model.result('pg2').feature('plz1').set('legendmethod', 'manual');
model.result('pg2').feature('plz1').setIndex('legends', 'Reflection', 0);
model.result('pg2').create('plz2', 'Polarization');
model.result('pg2').feature('plz2').set('linestyle', 'solid');
model.result('pg2').feature('plz2').set('linewidth', 2);
model.result('pg2').feature('plz2').set('display', '0');
model.result('pg2').feature('plz2').create('col1', 'Color');
model.result('pg2').feature('plz2').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz2').feature('col1').set('colorlegend', false);
model.result('pg2').create('plz3', 'Polarization');
model.result('pg2').feature('plz3').set('linestyle', 'solid');
model.result('pg2').feature('plz3').set('linewidth', 2);
model.result('pg2').feature('plz3').set('display', '1');
model.result('pg2').feature('plz3').create('col1', 'Color');
model.result('pg2').feature('plz3').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz3').feature('col1').set('colorlegend', false);
model.result('pg2').create('plz4', 'Polarization');
model.result('pg2').feature('plz4').set('linestyle', 'solid');
model.result('pg2').feature('plz4').set('linewidth', 2);
model.result('pg2').feature('plz4').set('display', '3');
model.result('pg2').feature('plz4').create('col1', 'Color');
model.result('pg2').feature('plz4').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz4').feature('col1').set('colorlegend', false);
model.result('pg2').create('plz5', 'Polarization');
model.result('pg2').feature('plz5').set('linestyle', 'solid');
model.result('pg2').feature('plz5').set('linewidth', 2);
model.result('pg2').feature('plz5').set('display', '4');
model.result('pg2').feature('plz5').create('col1', 'Color');
model.result('pg2').feature('plz5').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz5').feature('col1').set('colorlegend', false);
model.result('pg2').create('plz6', 'Polarization');
model.result('pg2').feature('plz6').set('linestyle', 'dashed');
model.result('pg2').feature('plz6').set('linewidth', 2);
model.result('pg2').feature('plz6').set('display', '6');
model.result('pg2').feature('plz6').create('col1', 'Color');
model.result('pg2').feature('plz6').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz6').feature('col1').set('colorlegend', false);
model.result('pg2').feature('plz6').set('legend', true);
model.result('pg2').feature('plz6').set('legendmethod', 'manual');
model.result('pg2').feature('plz6').setIndex('legends', 'Transmission', 0);
model.result('pg2').create('plz7', 'Polarization');
model.result('pg2').feature('plz7').set('linestyle', 'dashed');
model.result('pg2').feature('plz7').set('linewidth', 2);
model.result('pg2').feature('plz7').set('display', '5');
model.result('pg2').feature('plz7').create('col1', 'Color');
model.result('pg2').feature('plz7').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz7').feature('col1').set('colorlegend', false);
model.result('pg2').create('plz8', 'Polarization');
model.result('pg2').feature('plz8').set('linestyle', 'dashed');
model.result('pg2').feature('plz8').set('linewidth', 2);
model.result('pg2').feature('plz8').set('display', '7');
model.result('pg2').feature('plz8').create('col1', 'Color');
model.result('pg2').feature('plz8').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').feature('plz8').feature('col1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('expr', 'ewfd.Ey');
model.result('pg1').feature('mslc1').set('colortable', 'WaveLight');
model.result('pg1').feature('mslc1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').run;
model.result('pg2').run;
model.result.dataset.create('arr1', 'Array3D');
model.result.dataset('arr1').set('fullsize', [3 1 1]);
model.result.dataset('arr1').set('floquetper', true);
model.result.dataset('arr1').set('wavevector', {'ewfd.kPeriodicx' '0' '0'});
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Ey in Array');
model.result('pg3').set('data', 'arr1');
model.result('pg3').set('titletype', 'none');
model.result('pg3').create('slc1', 'Slice');
model.result('pg3').feature('slc1').set('expr', 'ewfd.Ey');
model.result('pg3').feature('slc1').set('quickplane', 'zx');
model.result('pg3').feature('slc1').set('quickynumber', 1);
model.result('pg3').feature('slc1').set('colortable', 'WaveLight');
model.result('pg3').feature('slc1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').run;
model.result('pg3').set('showlegends', false);

model.view('view2').set('showgrid', false);
model.view('view2').set('showaxisorientation', false);

model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg3');
model.result.export('anim1').set('sweeptype', 'dde');
model.result.export('anim1').set('repeat', 'iterations');
model.result.export('anim1').set('iterations', 5);
model.result.export('anim1').run;

model.title('Metasurface Beam Deflector');

model.description(['This model demonstrates how to simulate a metasurface beam deflector that uses anomalous refraction. The structure itself is a repeated array of six posts (so-called meta elements). The periodicity of the individual posts is 500 nm, so the full structure of six posts is 3 um wide. The posts are 1 um tall, and the structure is designed to operate at a free space wavelength of 1.55 um.' newline  newline 'The cylindrical pillars are Silicon and the substrate is SiO2. The structure is designed so that incident light coming through the substrate at a normal angle of incidence will be refracted at prescribed angle - the anomalous refraction angle.' newline  newline 'To model this using COMSOL we apply Periodic Condition boundaries in the x and y directions, combined with Ports of the periodic type in the z direction. The Diffraction Order subnodes on the Ports will fully account for the transmission and reflection into each allowed diffraction direction.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('metasurface_beam_deflector.mph');

model.modelNode.label('Components');

out = model;
