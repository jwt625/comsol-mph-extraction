function out = model
%
% space_frame_instability.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('beam', 'HermitianBeam', 'geom1');
model.physics('beam').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/beam', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('P', '1', 'Load');
model.param.set('l1', '69.28', 'Projected length of inclined members on x-axis');
model.param.set('l2', '61.44', 'Length of in-plane members at the top');
model.param.set('b', '30', 'Frame width');
model.param.set('h1', '40', 'Frame height');
model.param.set('A1', '0.5', 'Area of type 1 members');
model.param.set('Iy1', '0.4', 'Area moment of inertia of type 1 members about local y axis');
model.param.set('Iz1', '0.133', 'Area moment of inertia of type 1 members about local z axis');
model.param.set('A2', '0.1', 'Area of type 2 members');
model.param.set('Iy2', '0.05', 'Area moment of inertia of type 2 members about local y axis');
model.param.set('Iz2', '0.05', 'Area moment of inertia of type 2 members about local z axis');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '-l1-l2/2 -l2/2 -l2/2 0');
model.geom('geom1').feature('pol1').set('y', '-b/2 -b/2 -b/2 -b/2');
model.geom('geom1').feature('pol1').set('z', '0 h1 h1 h1');
model.geom('geom1').run('pol1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-l2/2' '-b/2' 'h1'});
model.geom('geom1').feature('ls1').set('coord2', {'-l2/2' '0' 'h1'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'ls1' 'pol1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', {'-l2/2' '0' 'h1'});
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').selection('input').set({'ls1' 'mir1' 'pol1'});
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('axis', [1 0 0]);
model.geom('geom1').run('fin');

model.physics('beam').feature('emm1').set('IsotropicOption', 'EG');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('EG', 'Young''s_modulus_and_shear_modulus');
model.material('mat1').propertyGroup('EG').set('E', {'4.32e5'});
model.material('mat1').propertyGroup('EG').set('G', {'1.66e5'});
model.material('mat1').propertyGroup('def').set('density', {'0'});

model.physics('beam').feature('csd1').set('area', 'A1');
model.physics('beam').feature('csd1').set('Izz', 'Iz1');
model.physics('beam').feature('csd1').set('Iyy', 'Iy1');
model.physics('beam').feature('csd1').set('J_beam', 'Iy1+Iz1');
model.physics('beam').feature('csd1').feature('so1').set('OrientationMethod', 'vector_beam');
model.physics('beam').feature('csd1').feature('so1').set('vector_beam', [0 1 0]);
model.physics('beam').create('csd2', 'CrossSectionBeam', 1);
model.physics('beam').feature('csd2').selection.set([3 5 9 11]);
model.physics('beam').feature('csd2').set('area', 'A2');
model.physics('beam').feature('csd2').set('Izz', 'Iz2');
model.physics('beam').feature('csd2').set('Iyy', 'Iy2');
model.physics('beam').feature('csd2').set('J_beam', 'Iy2+Iz2');
model.physics('beam').feature('csd2').feature('so1').set('OrientationMethod', 'vector_beam');
model.physics('beam').feature('csd2').feature('so1').set('vector_beam', [1 0 0]);
model.physics('beam').create('pin1', 'Pinned', 0);
model.physics('beam').feature('pin1').selection.set([1 2 11 12]);
model.physics('beam').create('pl1', 'PointLoad', 0);
model.physics('beam').feature('pl1').selection.set([3 5 8 10]);
model.physics('beam').feature('pl1').set('Fp', {'0' '0' '-P'});
model.physics('beam').create('pl2', 'PointLoad', 0);
model.physics('beam').feature('pl2').selection.set([3 8]);
model.physics('beam').feature('pl2').set('Fp', {'0' '0.001*P' '0'});

model.mesh('mesh1').autoMeshSize(4);

model.study('std1').feature('stat').set('geometricNonlinearity', true);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'P', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'P', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.1,8) range(8.02, 0.02, 8.65)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_beam_uLin').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_beam_thLin').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_beam_thLin').set('scaleval', 'pi/10');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 40);
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 113, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'beam.mises'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (beam)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'beam.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('scaleactive', true);
model.result('pg1').feature('line1').feature('def').set('scale', '1');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Displacement (beam)');
model.result('pg1').run;
model.result('pg1').feature('line1').set('expr', 'beam.disp');
model.result('pg1').feature('line1').set('descr', 'Displacement magnitude');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Load vs. Displacement');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'v');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'P');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Load vs. displacement');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([4]);
model.result('pg2').feature('ptgr1').set('expr', 'P');
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'beam.uLinY');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'COMSOL', 0);
model.result('pg2').feature('ptgr1').set('linewidth', 3);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('space_frame_instability_data.txt');
model.result.table('tbl1').label('Reference Data');
model.result('pg2').run;
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg2').feature('tblp1').set('linewidth', 'preference');
model.result('pg2').feature('tblp1').set('linestyle', 'none');
model.result('pg2').feature('tblp1').set('linemarker', 'cycle');
model.result('pg2').feature('tblp1').set('markerpos', 'interp');
model.result('pg2').feature('tblp1').set('markers', 20);
model.result('pg2').feature('tblp1').set('legend', true);
model.result('pg2').feature('tblp1').set('legendmethod', 'manual');
model.result('pg2').feature('tblp1').setIndex('legends', 'Ref. data', 0);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('plotgroup', 'Default');
model.study('std2').feature('stat').set('solnum', 'auto');
model.study('std2').feature('stat').set('notsolnum', 'auto');
model.study('std2').feature('stat').set('outputmap', {});
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').setSolveFor('/physics/beam', true);
model.study('std2').create('buckling', 'LinearBuckling');
model.study('std2').feature('buckling').set('plotgroup', 'Default');
model.study('std2').feature('buckling').set('neigsactive', true);
model.study('std2').feature('buckling').set('solnum', 'auto');
model.study('std2').feature('buckling').set('notsolnum', 'auto');
model.study('std2').feature('buckling').set('outputmap', {});
model.study('std2').feature('buckling').set('ngenAUX', '1');
model.study('std2').feature('buckling').set('goalngenAUX', '1');
model.study('std2').feature('buckling').set('ngenAUX', '1');
model.study('std2').feature('buckling').set('goalngenAUX', '1');
model.study('std2').feature('buckling').setSolveFor('/physics/beam', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').create('su1', 'StoreSolution');
model.sol('sol2').create('st2', 'StudyStep');
model.sol('sol2').feature('st2').set('study', 'std2');
model.sol('sol2').feature('st2').set('studystep', 'buckling');
model.sol('sol2').create('v2', 'Variables');
model.sol('sol2').feature('v2').set('initmethod', 'sol');
model.sol('sol2').feature('v2').set('initsol', 'sol2');
model.sol('sol2').feature('v2').set('initsoluse', 'sol3');
model.sol('sol2').feature('v2').set('notsolmethod', 'sol');
model.sol('sol2').feature('v2').set('notsol', 'sol2');
model.sol('sol2').feature('v2').set('control', 'buckling');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol2').feature('e1').set('eigvfunscaleparam', '2.06E-4');
model.sol('sol2').feature('e1').set('control', 'buckling');
model.sol('sol2').feature('e1').set('linpmethod', 'sol');
model.sol('sol2').feature('e1').set('linpsol', 'sol2');
model.sol('sol2').feature('e1').set('linpsoluse', 'sol3');
model.sol('sol2').feature('e1').set('control', 'buckling');
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('v2').set('notsolnum', 'auto');
model.sol('sol2').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset2').set('frametype', 'spatial');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('defaultPlotID', 'modeShape');
model.result('pg3').set('showlegends', false);
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'beam.disp'});
model.result('pg3').feature('line1').set('threshold', 'manual');
model.result('pg3').feature('line1').set('thresholdvalue', 0.2);
model.result('pg3').feature('line1').set('colortable', 'Rainbow');
model.result('pg3').feature('line1').set('colortabletrans', 'none');
model.result('pg3').feature('line1').set('colorscalemode', 'linear');
model.result('pg3').label('Mode Shape (beam)');
model.result('pg3').feature('line1').set('colortable', 'AuroraBorealis');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'beam.re');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg3').feature('line1').set('tuberadiusscale', 1);
model.result('pg3').feature('line1').set('tubeendcaps', false);
model.result('pg3').feature('line1').create('def', 'Deform');
model.result('pg3').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg3').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg1').run;

model.title('Instability of a Space Arc Frame');

model.description(['This example illustrates the instability of a space arc frame under concentrated vertical loading. A small lateral load is applied to break the symmetry of the structure. Members in the frame are modeled using geometrically nonlinear beam elements.' newline  newline 'The results are compared with available literature data.']);

model.label('space_frame_instability.mph');

model.modelNode.label('Components');

out = model;
