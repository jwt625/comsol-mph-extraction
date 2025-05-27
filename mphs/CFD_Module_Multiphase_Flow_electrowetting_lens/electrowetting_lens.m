function out = model
%
% electrowetting_lens.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Multiphase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('spf').prop('ConsistentStabilization').set('CrosswindDiffusion', '0');

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'yeoh');
model.common('free1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [1.5 1]);
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 0.55, 0);

model.param.set('theta0', '140[deg]');
model.param.descr('theta0', 'Zero voltage contact angle');
model.param.set('gamma', '0.05[N/m]');
model.param.descr('gamma', 'Surface tension');
model.param.set('muoil', '8e-3[Pa*s]');
model.param.descr('muoil', 'Insulating fluid viscosity');
model.param.set('epsr', '2.65');
model.param.descr('epsr', 'Relative dielectric constant');
model.param.set('d_f', '3[um]');
model.param.descr('d_f', 'Dielectric thickness');
model.param.set('Vapp', '120[V]');
model.param.descr('Vapp', 'Applied voltage');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('theta', 'acos(cos(theta0)+Vapp^2*epsr*epsilon0_const/(2*gamma*d_f))');
model.variable('var1').descr('theta', 'Contact angle');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Insulating fluid');
model.material('mat1').selection.set([2]);
model.material('mat1').propertyGroup('def').set('density', {'1000'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'muoil'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Lithium chloride solution');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('density', {'1000'});
model.material('mat2').propertyGroup('def').set('dynamicviscosity', {'1.5e-3'});

model.physics('spf').create('ffi1', 'FluidFluidInterface', 1);
model.physics('spf').feature('ffi1').selection.set([4]);
model.physics('spf').feature('ffi1').set('SurfaceTensionCoefficient', 'userdef');
model.physics('spf').feature('ffi1').set('sigma', 'gamma');
model.physics('spf').feature('ffi1').feature('cnta1').set('thetac', 'theta');
model.physics('spf').feature('ffi1').feature('cnta1').set('ConstrainNormalWallVelocity', true);
model.physics('spf').create('wallbc2', 'WallBC', 1);
model.physics('spf').feature('wallbc2').selection.set([6 7]);
model.physics('spf').feature('wallbc2').set('BoundaryCondition', 'NavierSlip');
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([6]);

model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([1 3 6 7]);

model.mesh('mesh1').create('sca1', 'Scale');
model.mesh('mesh1').feature('sca1').selection.geom('geom1', 0);
model.mesh('mesh1').feature('sca1').selection.set([5]);
model.mesh('mesh1').feature('sca1').set('scale', 0.2);
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').run;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);
model.cpl('intop1').set('axisym', false);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'theta0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'theta0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'rad', 0);
model.study('std1').feature('param').setIndex('pname', 'muoil', 0);
model.study('std1').feature('param').setIndex('plistarr', '10e-3 30e-3 50e-3', 0);
model.study('std1').feature('time').set('tlist', 'range(0,1e-3,5e-2)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1.900251036047606E-5');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1e-3,5e-2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_p' 'scaled' 'comp1_spatial_disp' 'global' 'comp1_spatial_lm_nv' 'global' 'comp1_u' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_p' 'factor' 'comp1_spatial_disp' 'factor' 'comp1_spatial_lm_nv' 'factor' 'comp1_u' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_p' '1' 'comp1_spatial_disp' '0.1' 'comp1_spatial_lm_nv' '0.1' 'comp1_u' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, fluid flow variables () (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Multiplicative Schwarz, fluid flow variables ()');
model.sol('sol1').feature('t1').feature('i1').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('prefun', 'ddmul');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('ndom', 1);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('dompernodemaxactive', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('usecoarse', 'aggregation');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('maxcoarsedofactive', true);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('overlap', 2);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('meshoverlap', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('nullspace', 'rbm');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('ddboundary', 'dirichlet');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'muoil'});
model.batch('p1').set('plistarr', {'10e-3 30e-3 50e-3'});
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

model.result.dataset('dset2').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 51, 0);
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').setIndex('looplevel', 3, 1);
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 51, 0);
model.result('pg2').setIndex('looplevel', 3, 1);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').label('Revolution 2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset2');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Velocity, 3D (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'rev1');
model.result('pg3').setIndex('looplevel', 51, 0);
model.result('pg3').setIndex('looplevel', 3, 1);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 51, 0);
model.result('pg4').setIndex('looplevel', 3, 1);
model.result('pg4').label('Moving Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'surface');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([1 2]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('xlabel', 'r (mm)');
model.result('pg1').set('ylabel', 'z (mm)');
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('color', 'white');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').setIndex('looplevel', 1, 1);
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('xlabel', 'r (mm)');
model.result('pg2').set('ylabel', 'z (mm)');
model.result('pg2').run;
model.result('pg2').feature.remove('con1');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').run;
model.result('pg2').create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('color', 'white');
model.result('pg2').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'spf.rho');
model.result('pg5').run;
model.result('pg3').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').set('data', 'dset2');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Height of the meniscus (mm)');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'intop1(1)', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'mm', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Meniscus height', 0);
model.result('pg6').feature('glob1').set('xdataparamunit', 'ms');
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'inner');
model.result('pg6').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 1, 1);
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').run;

model.title('Electrowetting Lens');

model.description('This example shows an adjustable lens that is actuated by the electrowetting on dielectric (EWOD) effect. The meniscus produced between two immiscible fluids (one conducting and one insulating) is used to form the lens. An electric field is applied between the conducting fluid and a dielectric coated electrode on the wall of the lens chamber. Changing the field changes the contact angle for the contact line between the two fluids, this changes the shape of the lens.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('electrowetting_lens.mph');

model.modelNode.label('Components');

out = model;
