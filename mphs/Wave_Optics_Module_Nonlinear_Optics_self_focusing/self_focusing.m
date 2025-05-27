function out = model
%
% self_focusing.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Nonlinear_Optics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study.create('std1');
model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('solnum', 'auto');
model.study('std1').feature('wave').set('notsolnum', 'auto');
model.study('std1').feature('wave').set('outputmap', {});
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').set('ngenAUX', '1');
model.study('std1').feature('wave').set('goalngenAUX', '1');
model.study('std1').feature('wave').setSolveFor('/physics/ewbe', true);

model.param.set('lda0', '1.064[um]');
model.param.descr('lda0', 'Wavelength');
model.param.set('w0', '100*lda0');
model.param.descr('w0', 'Nominal spot radius');
model.param.set('n0', '1.52');
model.param.descr('n0', 'Refractive index of BK-7 glass');
model.param.set('x0', 'pi*n0*w0^2/lda0');
model.param.descr('x0', 'Rayleigh range');
model.param.set('k', '2*pi*n0/lda0');
model.param.descr('k', 'Propagation constant');
model.param.set('I0', '2.5[GW/cm^2]');
model.param.descr('I0', 'Nominal peak intensity');
model.param.set('E0', 'sqrt(2*I0/n0*sqrt(mu0_const/epsilon0_const))');
model.param.descr('E0', 'Nominal peak electric field');
model.param.set('length', '4*x0');
model.param.descr('length', 'Length of computation domain');
model.param.set('radius', '2.5*w0*sqrt(1+(length/(2*x0))^2)');
model.param.descr('radius', 'Radius of computation domain');
model.param.set('gamma', '4e-16[cm^2/W]');
model.param.descr('gamma', 'Nonlinear refractive index coefficient');
model.param.set('delta_n', 'gamma*I0');
model.param.descr('delta_n', 'Nominal refractive index change');
model.param.set('P_cr', '(1.22*pi)^2*lda0^2/(8*pi*n0*gamma)');
model.param.descr('P_cr', 'Critical power');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'radius');
model.geom('geom1').feature('cyl1').set('h', 'length');
model.geom('geom1').feature('cyl1').set('pos', {'-length/2' '0' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'length' 'radius' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'radius', 2);
model.geom('geom1').feature('blk1').set('pos', {'-length/2' '-radius' '0'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'blk1' 'cyl1'});
model.geom('geom1').run('fin');

model.view('view1').camera.set('viewscaletype', 'automatic');
model.view('view1').camera.set('autocontext', 'anisotropic');
model.view('view1').camera.set('autoupdate', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('BK-7 glass');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n0+gamma*ewbe.Poavx'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'intop_output_boundary');
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.set([5]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('P', 'intop_output_boundary(ewbe.nPoav)');
model.variable('var1').descr('P', 'Output power');
model.variable('var1').set('w_t', 'sqrt(2*intop_output_boundary(ewbe.nPoav*(y^2+z^2))/P)');
model.variable('var1').descr('w_t', 'Spot radius on output boundary');

model.physics('ewbe').prop('WaveVector').set('dirCount', 'UniDirectionality');
model.physics('ewbe').prop('WaveVector').set('k1', {'k' '0' '0'});
model.physics('ewbe').create('mbc1', 'MatchedBoundaryCondition', 2);
model.physics('ewbe').feature('mbc1').selection.set([1]);
model.physics('ewbe').feature('mbc1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('mbc1').set('w0', 'w0');
model.physics('ewbe').feature('mbc1').set('p0', 'length/2');
model.physics('ewbe').feature('mbc1').set('inputQuantity', 'Power');
model.physics('ewbe').feature('mbc1').set('inputPower', 'pi*w0^2/2*I0');
model.physics('ewbe').feature('mbc1').set('Eg0NN', {'0' '0' '1[V/m]'});
model.physics('ewbe').feature('mbc1').create('rpnt1', 'ReferencePoint', 0);
model.physics('ewbe').feature('mbc1').feature('rpnt1').selection.set([2]);
model.physics('ewbe').create('mbc2', 'MatchedBoundaryCondition', 2);
model.physics('ewbe').feature('mbc2').selection.set([5]);
model.physics('ewbe').create('symp1', 'SymmetryPlane', 2);
model.physics('ewbe').feature('symp1').selection.set([4]);
model.physics('ewbe').create('symp2', 'SymmetryPlane', 2);
model.physics('ewbe').feature('symp2').selection.set([2]);
model.physics('ewbe').feature('symp2').set('Symmetry_type', 'pec');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'x0/2');
model.mesh('mesh1').feature('ftri1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'w0/2');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'w0/4');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('wave').set('plist', 'lda0');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'lda0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'lda0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'I0', 0);
model.study('std1').feature('param').setIndex('plistarr', '1e7, 2e13, 5e13, 8e13, 11e13, 14e13', 0);
model.study('std1').feature('param').set('paramselect', false);

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
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'I0'});
model.batch('p1').set('plistarr', {'1e7, 2e13, 5e13, 8e13, 11e13, 14e13'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('st1').set('splitcomplex', true);
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickzmethod', 'coord');
model.result('pg1').feature('slc1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('slc1').feature('def1').set('expr', {'' '' 'ewbe.normE'});
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 2, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 5, 1);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 6, 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('slc1').set('expr', 'ewbe.normE/E0');
model.result('pg1').run;
model.result('pg1').feature('slc1').feature('def1').set('expr', {'' '' 'ewbe.normE/E0'});
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
model.result.export('anim1').set('solnumtype', 'level2');
model.result.export('anim1').set('frametime', 1);
model.result.export('anim1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('quickplane', 'xy');
model.result('pg2').feature('slc1').set('quickzmethod', 'coord');
model.result('pg2').feature('slc1').set('expr', 'ewbe.nxx-n0');
model.result('pg2').feature('slc1').create('def1', 'Deform');
model.result('pg2').run;
model.result('pg2').feature('slc1').feature('def1').set('expr', {'' '' 'ewbe.nxx-n0'});
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Nonlinear refractive index: ewbe.nxx-n0');
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', 'w_t', 0);
model.result.numerical('gev1').set('data', 'dset2');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'none');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('source', 'table');
model.result('pg3').feature('tblp1').set('table', 'tbl1');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').run;
model.result('pg3').feature('tblp1').set('xaxisdata', 1);
model.result('pg3').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg3').feature('tblp1').set('plotcolumns', [3]);
model.result('pg3').run;
model.result('pg3').set('axislimits', true);
model.result('pg3').set('ymin', '1.5e-4');
model.result('pg3').set('ymax', '2.5e-4');
model.result('pg3').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').setIndex('expr', 'w0*sqrt(1+(length/2/x0)^2)', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 2');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').setIndex('expr', '4*P/P_cr', 0);
model.result.numerical('gev3').set('data', 'dset2');
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Global Evaluation 3');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').setResult;
model.result('pg2').run;

model.title('Self-Focusing');

model.description('A Gaussian beam is launched into a BK-7 optical glass. The material has an intensity-dependent refractive index. For the center of the beam, the refractive index is the largest. This induced refractive index profile counteracts the diffractive effects and actually focuses the beam. Thereby the name self-focusing. Self-focusing is important in design of high-power laser systems. The model demonstrates 3D nonlinear wave propagation.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('self_focusing.mph');

model.modelNode.label('Components');

out = model;
