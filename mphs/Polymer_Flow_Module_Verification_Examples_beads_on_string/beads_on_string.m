function out = model
%
% beads_on_string.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Polymer_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('vef', 'ViscoelasticFlow', 'geom1');
model.physics('vef').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/vef', true);

model.baseSystem('none');

model.param.set('epsilon', '0.05');
model.param.descr('epsilon', 'Radius perturbation');
model.param.set('beta', '0.25');
model.param.descr('beta', 'Solvent viscosity ratio');
model.param.set('Oh', '3.16');
model.param.descr('Oh', 'Ohnesorge number');
model.param.set('De', '94.9');
model.param.descr('De', 'Deborah number');
model.param.set('mus', 'beta*Oh');
model.param.descr('mus', 'Solvent viscosity');
model.param.set('mup', '(1-beta)*Oh');
model.param.descr('mup', 'Elastic viscosity');

model.geom('geom1').create('pc1', 'ParametricCurve');
model.geom('geom1').feature('pc1').set('parmax', '8*pi');
model.geom('geom1').feature('pc1').set('coord', {'1+epsilon*cos(s/2)' ''});
model.geom('geom1').feature('pc1').setIndex('coord', 's', 1);
model.geom('geom1').run('pc1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', '1+epsilon', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', '8*pi', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', '1+epsilon', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', '8*pi', 3, 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'pc1' 'pol1'});
model.geom('geom1').runPre('fin');

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').selection.all;

model.geom('geom1').run;

model.common('free1').set('smoothingType', 'hyperelastic');

model.physics('vef').prop('ShapeProperty').set('order_fluid', 1);
model.physics('vef').feature('fp1').set('rho_mat', 'userdef');
model.physics('vef').feature('fp1').set('rho', 1);
model.physics('vef').feature('fp1').set('mu_s_mat', 'userdef');
model.physics('vef').feature('fp1').set('mu_s', 'mus');
model.physics('vef').feature('fp1').setIndex('mue', 'mup', 0, 0);
model.physics('vef').feature('fp1').setIndex('lambdae', 'De', 0, 0);
model.physics('vef').create('fs1', 'FreeSurface', 1);
model.physics('vef').feature('fs1').selection.set([4]);
model.physics('vef').feature('fs1').set('SurfaceTensionCoefficient', 'userdef');
model.physics('vef').feature('fs1').set('sigma', 1);
model.physics('vef').feature('fs1').feature('cnta1').set('ConstrainNormalWallVelocity', true);
model.physics('vef').create('pfc1', 'PeriodicFlowCondition', 1);
model.physics('vef').feature('pfc1').selection.set([2 3]);

model.common.create('sym1', 'Symmetry', 'comp1');
model.common('sym1').selection.set([1 2 3]);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').feature('size').set('hauto', 9);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.001);
model.mesh('mesh1').feature('size').set('hnarrow', 8);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5,300)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', 0.005);
model.study('std1').feature('time').set('autoremesh', true);

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
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '0.15986240959024733');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5,300)');
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
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_p' 'scaled' 'comp1_spatial_disp' 'global' 'comp1_spatial_lm_nv' 'global' 'comp1_u' 'global' 'comp1_vef_Te_1' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_p' 'factor' 'comp1_spatial_disp' 'factor' 'comp1_spatial_lm_nv' 'factor' 'comp1_u' 'factor' 'comp1_vef_Te_1' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_p' '1' 'comp1_spatial_disp' '0.1' 'comp1_spatial_lm_nv' '0.1' 'comp1_u' '0.1' 'comp1_vef_Te_1' '0.1'});
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
model.sol('sol1').feature('t1').feature('arDef').set('autoremeshgeom', 'geom1');
model.sol('sol1').feature('t1').feature('arDef').set('stopcondtype', 'quality');
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
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').set('hybridvar', {'comp1_u' 'comp1_p' 'comp1_spatial_disp' 'comp1_spatial_lm_nv'});
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('ds').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('i1').create('dd2', 'DomainDecomposition');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('prefun', 'ddhyb');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('ndom', 1);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('dompernodemaxactive', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('usecoarse', 'aggregation');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('maxcoarsedofactive', true);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('maxcoarsedof', 10000);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('overlap', 1);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('meshoverlap', true);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('ddboundary', 'dirichlet');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('hybridization', 'multi');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').set('hybridvar', {'comp1_vef_Te_1'});
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('ds').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('dd2').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
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
model.sol.create('sol2');
model.sol('sol2').label('Remeshed Solution 1');
model.sol('sol2').study('std1');
model.sol('sol1').feature('t1').feature('arDef').set('tadapsol', 'sol2');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.dataset('dset2').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (vef)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (vef)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset2');
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
model.result('pg3').label('Velocity, 3D (vef)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'rev1');
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset2');
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
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('data', 'dset2');
model.result('pg1').run;
model.result('pg1').set('data', 'mir1');

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');

model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'expr');
model.sol('sol1').feature('t1').set('maxstepexpressiongenalpha', 'comp1.vef.dt_CFL');
model.sol('sol1').feature('t1').feature('arDef').set('stopcondtype', 'distortion');
model.sol('sol1').feature('t1').feature('arDef').set('stopdistval', '1.05');
model.sol('sol1').feature('t1').feature('arDef').set('solutionremesh', 'tout');
model.sol('sol1').feature('t1').feature('arDef').set('consistentremesh', true);
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').label('Shape');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', '1');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'black');
model.result.numerical.create('min1', 'MinLine');
model.result.numerical('min1').selection.set([4]);
model.result.numerical('min1').setIndex('expr', 'log10(r)', 0);
model.result.numerical('min1').set('data', 'dset2');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Line Minimum 1');
model.result.numerical('min1').set('table', 'tbl1');
model.result.numerical('min1').setResult;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'none');
model.result('pg6').create('tblp1', 'Table');
model.result('pg6').feature('tblp1').set('source', 'table');
model.result('pg6').feature('tblp1').set('table', 'tbl1');
model.result('pg6').feature('tblp1').set('linewidth', 'preference');
model.result('pg6').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').label('Minimum  Radius');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('xlabel', 't');
model.result('pg6').run;
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('parmin1', 50);
model.result.dataset('grid1').set('parmax1', 300);
model.result('pg6').run;
model.result('pg6').create('fun1', 'Function');
model.result('pg6').feature('fun1').set('linewidth', 'preference');
model.result('pg6').feature('fun1').set('expr', '-1/(3*De*log(10))*x-0.3');
model.result('pg6').feature('fun1').set('xdataexpr', 'x');
model.result('pg6').feature('fun1').set('lowerbound', 150);
model.result('pg6').feature('fun1').set('upperbound', 250);
model.result('pg6').feature('fun1').set('data', 'grid1');
model.result('pg6').feature('fun1').set('linestyle', 'dashed');
model.result('pg6').feature('fun1').set('linewidth', 2);
model.result('pg6').feature('fun1').set('linecolor', 'black');
model.result('pg6').feature('fun1').set('legend', true);
model.result('pg6').feature('fun1').set('legendmethod', 'manual');
model.result('pg6').feature('fun1').setIndex('legends', 'slope= -1/(3*De*log(10))', 0);
model.result('pg6').feature('fun1').set('titletype', 'none');
model.result('pg6').run;
model.result('pg3').run;

model.title('Beads-on-String Structure of Viscoelastic Filaments');

model.description('This example applies an Oldroyd-B fluid to model the thinning of a viscoelastic filament under the action of surface tension. For times smaller than the polymer relaxation time, the filament develops a beads-on-string structure. At times much larger than the relaxation time, the solution consists of almost spherical drops connected by exponentially thinning threads. Both transient regimes compare well with experimental measurements.');

model.label('beads_on_string.mph');

model.modelNode.label('Components');

out = model;
