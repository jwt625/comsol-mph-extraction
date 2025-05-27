function out = model
%
% optical_yagi_uda_antenna.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Optical_Scattering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ebem', 'ElectromagneticWavesBEM', 'geom1');
model.physics('ebem').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ebem', true);

model.geom('geom1').lengthUnit('nm');

model.param.set('py', '4e-24[C*m]');
model.param.descr('py', 'Dipole moment, y-component');
model.param.set('xp', '0[nm]');
model.param.descr('xp', 'Dipole position, x-component');
model.param.set('yp', '-100[nm]');
model.param.descr('yp', 'Dipole position, y-component');
model.param.set('zp', '0[nm]');
model.param.descr('zp', 'Dipole position, z-component');
model.param.set('lda0', '570[nm]');
model.param.descr('lda0', 'Wavelength');
model.param.set('epsilon', '-38-10.9j');
model.param.descr('epsilon', 'Dielectric constant of aluminum');
model.param.set('L_f', '160[nm]');
model.param.descr('L_f', 'Feed length');
model.param.set('L_d', '0.9*L_f');
model.param.descr('L_d', 'Director length');
model.param.set('L_r', '1.25*L_f');
model.param.descr('L_r', 'Reflector length');
model.param.set('a_d', 'lda0/4');
model.param.descr('a_d', 'Director spacing');
model.param.set('a_r', 'lda0/4.4');
model.param.descr('a_r', 'Reflector spacing');
model.param.set('r', '20[nm]');
model.param.descr('r', 'Antenna radius');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('R', 'sqrt((x-xp)^2+(y-yp)^2+(z-zp)^2)');
model.variable('var1').descr('R', 'Distance from the point-dipole to a point in space');
model.variable('var1').set('Rx', '(x-xp)/R');
model.variable('var1').descr('Rx', 'Unit vector from the point-dipole to a point in space, x-component');
model.variable('var1').set('Ry', '(y-yp)/R');
model.variable('var1').descr('Ry', 'Unit vector from the point-dipole to a point in space, y-component');
model.variable('var1').set('Rz', '(z-zp)/R');
model.variable('var1').descr('Rz', 'Unit vector from the point-dipole to a point in space, z-component');
model.variable('var1').set('K', '1/(4*pi*epsilon0_const)');
model.variable('var1').descr('K', 'Variable to simplify expressions in the background field');
model.variable('var1').set('F1', 'ebem.omega^2/(c_const^2*R)');
model.variable('var1').descr('F1', 'Variable to simplify expressions in the background field');
model.variable('var1').set('F2', '1/R^3+j*ebem.omega/(c_const*R^2)');
model.variable('var1').descr('F2', 'Variable to simplify expressions in the background field');
model.variable('var1').set('F3', 'exp(-j*ebem.omega*R/c_const)');
model.variable('var1').descr('F3', 'Variable to simplify expressions in the background field');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'r');
model.geom('geom1').feature('cyl1').set('h', 'L_r-2*r');
model.geom('geom1').feature('cyl1').set('pos', {'-a_r' '-(L_r-2*r)/2' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'y');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('h', 'L_f-2*r');
model.geom('geom1').feature('cyl2').setIndex('pos', 0, 0);
model.geom('geom1').feature('cyl2').set('pos', {'0' '-(L_f-2*r)/2' '0'});
model.geom('geom1').feature.duplicate('cyl3', 'cyl2');
model.geom('geom1').feature('cyl3').set('h', 'L_d-2*r');
model.geom('geom1').feature('cyl3').set('pos', {'0' '-(L_d-2*r)/2' '0'});
model.geom('geom1').feature('cyl3').setIndex('pos', 'a_d', 0);
model.geom('geom1').run('cyl3');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'r');
model.geom('geom1').feature('sph1').set('pos', {'0' 'L_f/2-r' '0'});
model.geom('geom1').feature.duplicate('sph2', 'sph1');
model.geom('geom1').feature('sph2').set('pos', {'0' '-L_f/2+r' '0'});
model.geom('geom1').feature.duplicate('sph3', 'sph2');
model.geom('geom1').feature('sph3').set('pos', {'-a_r' '-L_r/2+r' '0'});
model.geom('geom1').feature.duplicate('sph4', 'sph3');
model.geom('geom1').feature('sph4').set('pos', {'-a_r' 'L_r/2-r' '0'});
model.geom('geom1').feature.duplicate('sph5', 'sph4');
model.geom('geom1').feature('sph5').set('pos', {'a_d' 'L_d/2-r' '0'});
model.geom('geom1').feature.duplicate('sph6', 'sph5');
model.geom('geom1').feature('sph6').set('pos', {'a_d' '-L_d/2+r' '0'});
model.geom('geom1').run('sph6');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cyl3' 'sph5' 'sph6'});
model.geom('geom1').feature('arr1').set('fullsize', [3 1 1]);
model.geom('geom1').feature('arr1').set('displ', {'a_d' '0' '0'});
model.geom('geom1').run;

model.physics('ebem').feature('wee1').set('DisplacementFieldModel', 'RelativePermittivity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').selection.set([]);
model.material('mat1').selection.allVoids;
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Al');
model.material('mat2').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'epsilon'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('ebem').prop('BackgroundField').set('SolveFor', 'scatteredField');
model.physics('ebem').prop('BackgroundField').set('Eb', {'K*(F1*(-Rx*Ry)+F2*3*Rx*Ry)*F3*py' 'K*(F1*(-(Rz^2+Rx^2))+F2*(3*Ry^2-1))*F3*py' 'K*(F1*(-Ry*Rz)+F2*3*Ry*Rz)*F3*py'});
model.physics('ebem').create('wee2', 'WaveEquationElectric', 3);
model.physics('ebem').feature('wee2').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ebem').feature('wee2').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]);
model.physics('ebem').create('ffc1', 'FarFieldCalculation', 2);

model.study('std1').feature('wave').set('plist', 'lda0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'wave');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'wave');
model.sol('sol1').create('s1', 'Stationary');
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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (ebem)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('mumpsblr', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('mumpsblrtol', '1.0E-6');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field, Boundaries (ebem)');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/VectorBEM/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('data', 'dset1');
model.result.dataset('grid1').set('par1', 'x');
model.result.dataset('grid1').set('par2', 'y');
model.result.dataset('grid1').set('par3', 'z');
model.result.dataset('grid1').set('parmin1', -746.590909090909);
model.result.dataset('grid1').set('parmax1', 1044.5454545454545);
model.result.dataset('grid1').set('parmin2', -300);
model.result.dataset('grid1').set('parmax2', 300);
model.result.dataset('grid1').set('parmin3', -60.000000000000014);
model.result.dataset('grid1').set('parmax3', 60.00000000000003);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'grid1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('expr', {'ebem.normE'});
model.result('pg2').feature('mslc1').set('colortable', 'RainbowLight');
model.result('pg2').label('Electric Field, Domains (ebem)');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'1'});
model.result('pg2').feature('line1').set('data', 'dset1');
model.result('pg2').feature('line1').set('titletype', 'none');
model.result('pg2').feature('line1').set('coloring', 'uniform');
model.result('pg2').feature('line1').set('color', 'black');
model.result('pg2').feature('line1').set('solutionparams', 'parent');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'ebem.normtrelE'});
model.result('pg2').feature('surf1').set('data', 'dset1');
model.result('pg2').feature('surf1').set('inheritplot', 'mslc1');
model.result.create('pg3', 'PolarGroup');
model.result('pg3').label('2D Far Field (ebem)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('rp1', 'RadiationPattern');
model.result('pg3').feature('rp1').set('legend', 'on');
model.result('pg3').feature('rp1').set('phidisc', '180');
model.result('pg3').feature('rp1').set('expr', {'ebem.normEfar'});
model.result('pg1').run;
model.result.dataset('grid1').set('parmin1', -5000);
model.result.dataset('grid1').set('parmax1', 5000);
model.result.dataset('grid1').set('parmin2', -5000);
model.result.dataset('grid1').set('parmax2', 5000);
model.result.dataset('grid1').set('parmin3', -5000);
model.result.dataset('grid1').set('parmax3', 5000);
model.result.dataset('grid1').set('res1', 200);
model.result.dataset('grid1').set('res2', 200);
model.result.dataset('grid1').set('res3', 200);
model.result('pg2').run;
model.result('pg2').set('titletype', 'none');
model.result('pg2').run;
model.result('pg2').feature('mslc1').set('rangecoloractive', true);
model.result('pg2').feature('mslc1').set('rangecolormin', 0);
model.result('pg2').feature('mslc1').set('rangecolormax', '1e8');
model.result('pg2').feature('mslc1').set('colorscalemode', 'logarithmic');
model.result('pg2').feature('mslc1').set('colortable', 'ThermalWave');

model.view('view2').camera.setIndex('position', 37899.5390625, 0);
model.view('view2').camera.set('zoomanglefull', 17.559436798095703);
model.view('view2').camera.setIndex('position', 77364.015625, 1);
model.view('view2').camera.setIndex('position', -29106.40234375, 2);
model.view('view2').camera.set('target', [0 0 -0.001953125]);
model.view('view2').camera.setIndex('up', -0.12846389412879944, 0);
model.view('view2').camera.setIndex('up', -0.293464720249176, 1);
model.view('view2').camera.setIndex('up', -0.9472978115081787, 2);
model.view('view2').set('showaxisorientation', false);

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').set('titletype', 'none');
model.result('pg4').create('rp1', 'RadiationPattern');
model.result('pg4').feature('rp1').set('expr', 'ebem.normEfar^2');
model.result('pg4').feature('rp1').set('thetadisc', 100);
model.result('pg4').feature('rp1').set('phidisc', 100);
model.result('pg4').feature('rp1').set('colorlegend', false);
model.result('pg4').feature('rp1').create('tran1', 'Transparency');
model.result('pg4').run;
model.result('pg4').feature('rp1').feature('tran1').set('transparency', 0.35);
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg4').run;

model.view('view3').set('showaxisorientation', false);
model.view('view3').set('showgrid', false);

model.result('pg4').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg4').feature('surf1').feature('mtrl1').set('family', 'custom');
model.result('pg4').feature('surf1').feature('mtrl1').set('fresnel', 0.45);
model.result('pg4').feature('surf1').feature('mtrl1').set('roughness', 0.4);
model.result('pg4').feature('surf1').feature('mtrl1').set('anisotropy', 0.35);

model.view('view3').camera.setIndex('position', 4215.71728515625, 0);
model.view('view3').camera.set('zoomanglefull', 9.5);
model.view('view3').camera.setIndex('position', 7550.5, 1);
model.view('view3').camera.setIndex('position', -2834.17626953125, 2);
model.view('view3').camera.setIndex('target', 525.070556640625, 0);
model.view('view3').camera.setIndex('target', 16.81298828125, 1);
model.view('view3').camera.setIndex('target', 0.197265625, 2);
model.view('view3').camera.setIndex('up', -0.12846389412879944, 0);
model.view('view3').camera.setIndex('up', -0.293464720249176, 1);
model.view('view3').camera.setIndex('up', -0.9472978115081787, 2);

model.title(['Optical Yagi' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Uda Antenna']);

model.description(['This model demonstrates the use of the boundary element method in the Electromagnetic Waves, Boundary Element interface to model an optical Yagi' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Uda antenna. The antenna is driven by an electrical point dipole, which is implemented through the background field. The field distribution around the antenna and the far-field radiation pattern are evaluated, showing high directivity.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('optical_yagi_uda_antenna.mph');

model.modelNode.label('Components');

out = model;
