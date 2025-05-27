function out = model
%
% jet_instability_mm.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Two-Phase_Flow');

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

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [5 60]);
model.geom('geom1').feature('r1').set('pos', [0 -30]);
model.geom('geom1').runPre('fin');

model.param.set('rhoink', '1e3[kg/m^3]');
model.param.descr('rhoink', 'Density, ink');
model.param.set('etaink', '1e-3[Pa*s]');
model.param.descr('etaink', 'Dynamic viscosity, ink');
model.param.set('sigma0', '0.07[N/m]');
model.param.descr('sigma0', 'Reference surface tension coefficient');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('sigma', 'sigma0*(1-0.2*cos(2*pi*Z/60[um]))');
model.variable('var1').descr('sigma', 'Surface tension coefficient');

model.physics('spf').feature('fp1').set('rho_mat', 'userdef');
model.physics('spf').feature('fp1').set('rho', 'rhoink');
model.physics('spf').feature('fp1').set('mu_mat', 'userdef');
model.physics('spf').feature('fp1').set('mu', 'etaink');
model.physics('spf').create('fs1', 'FreeSurface', 1);
model.physics('spf').feature('fs1').selection.set([4]);
model.physics('spf').feature('fs1').set('SurfaceTensionCoefficient', 'userdef');
model.physics('spf').feature('fs1').set('sigma', 'sigma');
model.physics('spf').feature('wallbc1').set('BoundaryCondition', 'NavierSlip');

model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([2 3]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('size').set('hauto', 8);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.5e-6,1e-5)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '6.637801593901402E-7');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.5e-6,1e-5)');
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
model.sol('sol1').feature('t1').setEntry('atolmethod', 'comp1_u', 'unscaled');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
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
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Velocity, 3D (spf)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'rev1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 21, 0);
model.result('pg4').label('Moving Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'surface');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'spf.rho');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'black');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 13, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 19, 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 1, 0);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'sigma');
model.result('pg6').run;
model.result('pg3').run;

model.title(['Jet Instability ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Moving Mesh']);

model.description('The Marangoni effect produces a slip velocity in the tangential direction on a fluid/fluid interface when gradients in the surface tension coefficient are present. In this example, a long fluid jet breaks up in the inertial reference frame as a result of a periodic surface tension gradient.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('jet_instability_mm.mph');

model.modelNode.label('Components');

out = model;
