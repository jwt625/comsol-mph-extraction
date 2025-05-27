function out = model
%
% step_index_fiber_bend.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Waveguides');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('mode', 'ModeAnalysis');
model.study('std1').feature('mode').set('shiftactive', false);
model.study('std1').feature('mode').set('conrad', '1');
model.study('std1').feature('mode').set('conradynhm', '1');
model.study('std1').feature('mode').set('linpsolnum', 'auto');
model.study('std1').feature('mode').set('outputmap', {});
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').setSolveFor('/physics/ewfd', true);

model.param.set('lda0', '1.55[um]');
model.param.descr('lda0', 'Wavelength');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Frequency');
model.param.set('nClad', '1.4378');
model.param.descr('nClad', 'Refractive index, cladding');
model.param.set('nCore', '1.4457');
model.param.descr('nCore', 'Refractive index, core');
model.param.set('aCore', '8[um]');
model.param.descr('aCore', 'Core radius');
model.param.set('aClad', '40[um]');
model.param.descr('aClad', 'Cladding radius');
model.param.set('Rb', '3[mm]');
model.param.descr('Rb', 'Bend radius');
model.param.set('aSquare', '100[um]');
model.param.descr('aSquare', 'Side length of square');
model.param.set('tPML', '20[um]');
model.param.descr('tPML', 'PML thickness');
model.param.set('dr', 'aSquare/2-tPML');
model.param.descr('dr', 'Distance from core center to PML boundary');
model.param.set('ldaPML', 'lda0/sqrt(nClad^2-(nCore*Rb/(Rb+dr))^2)');
model.param.descr('ldaPML', 'Radial wavelength in PML');

model.material.create('mat1', 'Common', '');
model.material('mat1').label('Silica Glass');
model.material.create('mat2', 'Common', '');
model.material('mat2').label('Doped Silica Glass');

model.modelNode('comp1').label('Straight Fiber');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'aClad');
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'aCore');
model.geom('geom1').run('c2');
model.geom('geom1').run;

model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').label('Cladding');
model.material.create('matlnk2', 'Link', 'comp1');
model.material('matlnk2').label('Core');
model.material('matlnk2').set('link', 'mat2');
model.material('matlnk2').selection.set([2]);
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nClad'});
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nCore'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.all;
model.variable('var1').set('normEt', '(ewfd.Ex*ewfd.Ex+ewfd.Ey*ewfd.Ey)/sqrt(ewfd.Ex*ewfd.Ex+ewfd.Ey*ewfd.Ey)');
model.variable('var1').descr('normEt', 'Transverse electric field norm');

model.mesh('mesh1').autoMeshSize(3);

model.study('std1').feature('mode').set('shiftactive', true);
model.study('std1').feature('mode').set('shift', 'nCore');
model.study('std1').feature('mode').set('modeFreq', 'f0');
model.study('std1').label('Study 1 (Straight Fiber)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'mode');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'mode');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').set('looplevel', [6]);
model.result('pg1').set('phasetype', 'manual');
model.result('pg1').set('phase', 45);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'normEt');
model.result('pg1').feature('surf1').set('descr', 'Transverse electric field norm');
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws1').set('descr', 'Electric field');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ez');
model.result('pg1').feature('surf1').set('descr', 'Electric field, z-component');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'ewfd.Hz');
model.result('pg1').feature('con1').set('descr', 'Magnetic field, z-component');
model.result('pg1').run;
model.result.dataset('dset1').label('Solution 1 (Straight Fiber)');
model.result('pg1').run;
model.result('pg1').label('Straight Fiber');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');
model.geom('geom2').axisymmetric(true);

model.mesh.create('mesh2', 'geom2');

model.modelNode('comp2').label('Bent Fiber');

model.geom('geom2').create('c1', 'Circle');
model.geom('geom2').feature('c1').set('r', 'aCore');
model.geom('geom2').feature('c1').set('pos', {'Rb' '0'});
model.geom('geom2').run('c1');
model.geom('geom2').create('sq1', 'Square');
model.geom('geom2').feature('sq1').set('size', 'aSquare');
model.geom('geom2').feature('sq1').set('base', 'center');
model.geom('geom2').feature('sq1').set('pos', {'Rb' '0'});
model.geom('geom2').run('sq1');
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', {'aSquare' 'tPML'});
model.geom('geom2').feature('r1').set('pos', {'Rb-aSquare/2' '0'});
model.geom('geom2').feature('r1').setIndex('pos', 'aSquare/2-tPML', 1);
model.geom('geom2').run('r1');
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', {'tPML' 'aSquare'});
model.geom('geom2').feature('r2').set('pos', {'Rb+dr' '-aSquare/2'});
model.geom('geom2').run('r2');
model.geom('geom2').create('r3', 'Rectangle');
model.geom('geom2').feature('r3').set('size', {'aSquare' 'tPML'});
model.geom('geom2').feature('r3').set('pos', {'Rb-aSquare/2' '0'});
model.geom('geom2').feature('r3').setIndex('pos', '-aSquare/2', 1);
model.geom('geom2').runPre('fin');

model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom2');
model.physics('ewfd2').model('comp2');

model.study('std1').feature('mode').setSolveFor('/physics/ewfd2', false);

model.geom('geom2').run;

model.physics('ewfd2').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('ewfd2').feature('pmc1').selection.set([1 2 3 5 7 9 14 15 16 17]);

model.material.create('matlnk3', 'Link', 'comp2');
model.material('matlnk3').label('Cladding');
model.material.create('matlnk4', 'Link', 'comp2');
model.material('matlnk4').label('Core');
model.material('matlnk4').selection.set([7]);
model.material('matlnk4').set('link', 'mat2');

model.coordSystem.create('pml1', 'geom2', 'PML');
model.coordSystem('pml1').selection.set([1 3 4 5 6]);
model.coordSystem('pml1').set('ScalingType', 'Cylindrical');
model.coordSystem('pml1').set('stretchingType', 'rational');
model.coordSystem('pml1').set('wavelengthSourceType', 'userDefined');
model.coordSystem('pml1').set('typicalWavelength', 'ldaPML');

model.cpl.create('intop1', 'Integration', 'geom2');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([2 7]);
model.cpl('intop1').set('axisym', false);

model.variable.create('var2');
model.variable('var2').model('comp2');
model.variable('var2').set('r0', 'intop1(r*ewfd2.Poavphi)/intop1(ewfd2.Poavphi)');

model.mesh('mesh2').contribute('physics/ewfd2', false);
model.mesh('mesh2').automatic(false);
model.mesh('mesh2').feature('size').set('hauto', 3);
model.mesh('mesh2').feature('ftri1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('ftri1').selection.set([2 7]);
model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('map1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('map1').selection.set([1 3 4 5 6]);
model.mesh('mesh2').feature('map1').create('size1', 'Size');
model.mesh('mesh2').feature('map1').feature('size1').set('hauto', 1);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('mode', 'ModeAnalysis');
model.study('std2').feature('mode').set('plotgroup', 'Default');
model.study('std2').feature('mode').set('shiftactive', false);
model.study('std2').feature('mode').set('conrad', '1');
model.study('std2').feature('mode').set('conradynhm', '1');
model.study('std2').feature('mode').set('linpsolnum', 'auto');
model.study('std2').feature('mode').set('solnum', 'auto');
model.study('std2').feature('mode').set('notsolnum', 'auto');
model.study('std2').feature('mode').set('outputmap', {});
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').setSolveFor('/physics/ewfd', false);
model.study('std2').feature('mode').setSolveFor('/physics/ewfd2', true);
model.study('std2').feature('mode').set('neigsactive', true);
model.study('std2').feature('mode').set('neigs', 2);
model.study('std2').feature('mode').set('shiftactive', true);
model.study('std2').feature('mode').set('shift', 'nCore');
model.study('std2').feature('mode').set('modeFreq', 'f0');
model.study('std2').label('Study 2 (Bent Fiber)');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'mode');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'mode');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('neigs', 6);
model.sol('sol2').feature('e1').set('shift', '0');
model.sol('sol2').feature('e1').set('control', 'mode');
model.sol('sol2').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('e1').create('d1', 'Direct');
model.sol('sol2').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd2)');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd2)');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset3');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset3');
model.result('pg2').run;
model.result.dataset('dset3').label('Solution 3 (Bent Fiber)');
model.result('pg2').run;
model.result('pg2').set('looplevel', [2]);
model.result('pg2').set('phasetype', 'manual');
model.result('pg2').set('phase', 45);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'ewfd2.Ez');
model.result('pg2').feature('surf1').set('colortable', 'Wave');
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'ewfd2.Hphi');
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('color', 'black');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'ewfd2.Er' 'ewfd2.Ez'});
model.result('pg2').feature('arws1').set('descr', 'Electric field');
model.result('pg2').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('arws1').set('color', 'black');
model.result.dataset('dset3').selection.geom('geom2', 2);
model.result.dataset('dset3').selection.geom('geom2', 2);
model.result.dataset('dset3').selection.set([2 7]);
model.result('pg2').run;
model.result('pg2').label('Bent Fiber');
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('plotgroup', 'pg2');
model.result.export('anim1').set('sweeptype', 'dde');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('r0');
model.result.numerical('gev1').set('data', 'dset3');
model.result.numerical('gev1').setIndex('looplevelinput', 'manual', 0);
model.result.numerical('gev1').setIndex('looplevel', [2], 0);
model.result.numerical('gev1').set('expr', {'r0'});
model.result.numerical('gev1').set('descr', {''});
model.result.numerical('gev1').set('unit', {'m'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('r0');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('n_eff_geometry');
model.result.numerical('gev2').set('data', 'dset3');
model.result.numerical('gev2').setIndex('looplevelinput', 'manual', 0);
model.result.numerical('gev2').setIndex('looplevel', [2], 0);
model.result.numerical('gev2').setIndex('expr', 'real(ewfd2.neff)', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('n_eff_geometry');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('n_eff_power');
model.result.numerical('gev3').set('data', 'dset3');
model.result.numerical('gev3').setIndex('looplevelinput', 'manual', 0);
model.result.numerical('gev3').setIndex('looplevel', [2], 0);
model.result.numerical('gev3').setIndex('expr', 'real(ewfd2.neff*ewfd2.rAverage)/r0', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('n_eff_power');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result('pg2').run;

model.title('Step-Index Fiber Bend');

model.description(['The first part of the model computes the modes for a straight step index fiber made of silica glass.' newline 'In the second part, a step index fiber bend with a 3' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm radius of curvature is analyzed with respect to propagating modes and radiation loss. It is shown how to find the power averaged mode radius and how to use this to compute the effective mode index.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('step_index_fiber_bend.mph');

model.modelNode.label('Components');

out = model;
