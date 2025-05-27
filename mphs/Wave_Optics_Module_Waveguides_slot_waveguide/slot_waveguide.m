function out = model
%
% slot_waveguide.m
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

model.param.set('w_slab', '180[nm]');
model.param.descr('w_slab', 'Width of slab');
model.param.set('w_slot', '50[nm]');
model.param.descr('w_slot', 'Width of slot');
model.param.set('h_slot', '300[nm]');
model.param.descr('h_slot', 'Height of slot');
model.param.set('lda0', '1.55[um]');
model.param.descr('lda0', 'Operating wavelength');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Operating frequency');
model.param.set('n_slab', '3.48');
model.param.descr('n_slab', 'Refractive index of slab');
model.param.set('n_slot', '1.44');
model.param.descr('n_slot', 'Refractive index of slot');
model.param.set('n_clad', '1.44');
model.param.descr('n_clad', 'Refractive index of cladding');
model.param.set('a', '2[um]');
model.param.descr('a', 'Exterior domain side length');
model.param.set('b', '800[nm]');
model.param.descr('b', 'Interior domain width');
model.param.set('c', '500[nm]');
model.param.descr('c', 'Interior domain height');

model.geom('geom1').lengthUnit('nm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'w_slot' 'h_slot'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'w_slab' 'h_slot'});
model.geom('geom1').feature('r2').set('pos', {'w_slot/2' '-h_slot/2'});
model.geom('geom1').run('r2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'r2'});
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displx', '-w_slot-w_slab');
model.geom('geom1').run('mov1');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'a' 'a'});
model.geom('geom1').feature('r3').set('base', 'center');
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'b' 'c'});
model.geom('geom1').feature('r4').set('base', 'center');
model.geom('geom1').run('r4');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-b/2' '0'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'b/2' '0'});
model.geom('geom1').runPre('fin');

model.cpl.create('maxop1', 'Maximum', 'geom1');

model.geom('geom1').run;

model.cpl('maxop1').label('Maximum 1 (Center)');
model.cpl('maxop1').selection.geom('geom1', 1);
model.cpl('maxop1').selection.set([7 12 17 22 26]);
model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Integration 1 (Slot)');
model.cpl('intop1').selection.set([6 7]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.set([1 2 3 4 5 6 7 8 9]);
model.cpl('intop2').label('Integration 2 (Complete Waveguide)');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Slot');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_slot'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Slab');
model.material('mat2').selection.set([4 5 8 9]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_slab'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Cladding');
model.material('mat3').selection.set([1 2 3]);
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'n_clad'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', false);
model.mesh('mesh1').feature('size1').selection.set([2 3 4 5 6 7 8 9]);
model.mesh('mesh1').feature('size1').set('hmax', 'c/20');
model.mesh('mesh1').run;

model.study('std1').feature('mode').set('modeFreq', 'f0');
model.study('std1').feature('mode').set('neigsactive', true);
model.study('std1').feature('mode').set('neigs', 2);
model.study('std1').feature('mode').set('shiftactive', true);
model.study('std1').feature('mode').set('shift', 'n_slab');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'w_slab', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'w_slab', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'w_slot', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(30[nm],10[nm],140[nm])', 0);
model.study('std1').feature('param').setIndex('punit', 'nm', 0);

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

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'w_slot'});
model.batch('p1').set('plistarr', {'range(30[nm],10[nm],140[nm])'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 12, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 12, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').set('looplevel', [1 3]);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewfd.Ex');
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('expr', 'ewfd.Ex');
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('color', 'gray');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').create('sel1', 'Selection');
model.result('pg1').feature('arws1').feature('sel1').selection.set([6 7]);
model.result('pg1').run;
model.result('pg1').feature('arws1').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws1').set('descr', 'Electric field');
model.result('pg1').feature('arws1').set('xnumber', 2);
model.result('pg1').feature('arws1').set('ynumber', 30);
model.result('pg1').feature('arws1').set('scaleactive', true);
model.result('pg1').feature('arws1').set('scale', 20000);
model.result('pg1').feature('arws1').set('color', 'white');
model.result('pg1').run;
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Surface and Contour: E<sub>x</sub> (V/m). Arrow Surface: Electric field. Slot width: 50 nm');
model.result('pg1').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset2');
model.result.dataset('cln1').setIndex('genpoints', '-b/2', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'b/2', 1, 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Normalized Transverse Electric Field');
model.result('pg2').set('data', 'cln1');
model.result('pg2').setIndex('looplevelinput', 'manual', 1);
model.result('pg2').setIndex('looplevel', [3], 1);
model.result('pg2').setIndex('looplevelinput', 'first', 0);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Normalized transverse electric field (E<sub>x</sub>) through the center of waveguide.');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Normalized transverse electric field');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').set('expr', 'ewfd.Ex/maxop1(ewfd.Ex)');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Transverse Electric Field');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('looplevel', [1 3]);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'ewfd.Ex');
model.result('pg3').feature('surf1').create('hght1', 'Height');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Normalized Power and Intensity');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevelinput', 'first', 0);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Normalized power and intensity in slot');
model.result('pg4').set('twoyaxes', true);
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Slot width (nm)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Normalized power (%)');
model.result('pg4').set('yseclabelactive', true);
model.result('pg4').set('yseclabel', 'Normalized intensity (1/um^2)');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'intop1(ewfd.Poavz)*100/intop2(ewfd.Poavz)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').feature('glob1').set('xdatasolnumtype', 'outer');
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'w_slot');
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'Normalized power', 0);
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('expr', 'intop1(ewfd.Poavz)/intop2(ewfd.Poavz)/(w_slot*h_slot)', 0);
model.result('pg4').feature('glob2').setIndex('unit', '1/um^2', 0);
model.result('pg4').feature('glob2').setIndex('descr', '', 0);
model.result('pg4').feature('glob2').setIndex('legends', 'Normalized intensity', 0);
model.result('pg4').run;
model.result('pg4').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg4').set('legendpos', 'middleright');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Refractive index');
model.result('pg5').set('edges', false);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'ewfd.nxx');
model.result('pg5').feature('surf1').set('descr', 'Refractive index, real part, xx-component');
model.result('pg5').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg5').run;
model.result('pg5').create('ann1', 'Annotation');
model.result('pg5').feature('ann1').set('text', '$SiO_2$');
model.result('pg5').feature('ann1').set('posyexpr', '-a/4');
model.result('pg5').feature('ann1').set('latexmarkup', true);
model.result('pg5').feature('ann1').set('showpoint', false);
model.result('pg5').run;
model.result('pg5').create('ann2', 'Annotation');
model.result('pg5').feature('ann2').set('text', '$Si$');
model.result('pg5').feature('ann2').set('posxexpr', '-w_slot/2-2*w_slab/3');
model.result('pg5').feature('ann2').set('posyexpr', 5);
model.result('pg5').feature('ann2').set('latexmarkup', true);
model.result('pg5').feature('ann2').set('showpoint', false);
model.result('pg5').feature('ann2').set('color', 'white');
model.result('pg5').feature.duplicate('ann3', 'ann2');
model.result('pg5').run;
model.result('pg5').feature('ann3').set('posxexpr', 'w_slot/2+w_slab/3');
model.result('pg5').run;
model.result('pg5').run;
model.result.remove('pg5');
model.result('pg3').run;

model.title('Slot Waveguide');

model.description(['The model analyzes the mode propagation within a nano slot waveguide. In a slot waveguide configuration, two high refractive index slabs (~3.48) are placed adjacent to the low refractive index slot (~1.44). Mode analysis was performed on a 2D cross section of a slot waveguide for an operating wavelength of 1.55' native2unicode(hex2dec({'00' 'a0'}), 'unicode')  native2unicode(hex2dec({'03' 'bc'}), 'unicode') 'm. Further analysis was carried out to optimize the width of the slot to deliver maximum optical power and optical intensity through the slot area.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;

model.label('slot_waveguide.mph');

model.modelNode.label('Components');

out = model;
