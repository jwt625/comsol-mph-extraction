function out = model
%
% cylinder_flow_viscoelastic.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Polymer_Flow_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('vef', 'ViscoelasticFlow', 'geom1');
model.physics('vef').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/vef', true);

model.baseSystem('none');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [25 2]);
model.geom('geom1').feature('r1').set('pos', [-10 0]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [6 2]);
model.geom('geom1').feature('r2').set('pos', [-2 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1' 'r2'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').run('dif1');

model.param.set('Re', '1e-3');
model.param.descr('Re', 'Reynolds number');
model.param.set('Wi', '0.05');
model.param.descr('Wi', 'Weissenberg number');
model.param.set('mu_s', '0.59');
model.param.descr('mu_s', 'Solvent relative viscosity');
model.param.set('mu_p', '1-mu_s');
model.param.descr('mu_p', 'Polymer relative viscosity');

model.geom('geom1').run;

model.physics('vef').feature('fp1').set('rho_mat', 'userdef');
model.physics('vef').feature('fp1').set('rho', 'Re');
model.physics('vef').feature('fp1').set('mu_s_mat', 'userdef');
model.physics('vef').feature('fp1').set('mu_s', 'mu_s');
model.physics('vef').feature('fp1').setIndex('mue', 'mu_p', 0, 0);
model.physics('vef').feature('fp1').setIndex('lambdae', 'Wi', 0, 0);
model.physics('vef').create('inl1', 'InletBoundary', 1);
model.physics('vef').feature('inl1').selection.set([1]);
model.physics('vef').feature('inl1').set('U0in', '1.5*(1-(y/2)^2)');
model.physics('vef').feature('inl1').set('Te0', {'2*Wi*mu_p*uy^2' 'mu_p*uy' '0' 'mu_p*uy' '0' '0' '0' '0' '0'});
model.physics('vef').create('out1', 'OutletBoundary', 1);
model.physics('vef').feature('out1').selection.set([11]);
model.physics('vef').feature('out1').set('SuppressBackflow', false);
model.physics('vef').create('sym1', 'Symmetry', 1);
model.physics('vef').feature('sym1').selection.set([2 5 7 9]);

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').set('type', 'integral');
model.probe('bnd1').selection.set([12 13]);
model.probe('bnd1').set('probename', 'Cd');
model.probe('bnd1').set('expr', '-2*(vef.T_stressx)');
model.probe('bnd1').set('descractive', true);
model.probe('bnd1').set('descr', 'Cd');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size1').selection.set([5 7 12 13]);
model.mesh('mesh1').feature('size1').set('hauto', 2);
model.mesh('mesh1').run('size1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1 3]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([2 3]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([9 10]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 25);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 5);
model.mesh('mesh1').feature('map1').feature('dis2').set('reverse', true);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'Re', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'Re', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'Wi', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.05,1)', 0);
model.study('std1').feature('stat').set('pcontinuationmode', 'no');
model.study('std1').feature('stat').set('preusesol', 'yes');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

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
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (vef)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (vef)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsfilter', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsfilter', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i1').create('mg2', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('maxcoarsedof', 80000);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('strconn', 0.02);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').set('hybridvar', {'comp1_vef_Te_1'});
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('pr').feature('sc1').set('scgsfilter', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('po').feature('sc1').set('scgsfilter', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg2').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Hybrid Schwarz, fluid flow variables (vef)');
model.sol('sol1').feature('s1').feature('i2').create('dd1', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('prefun', 'ddhyb');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('ndom', 1);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('dompernodemaxactive', false);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('usecoarse', 'aggregation');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('maxcoarsedofactive', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('overlap', 1);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('meshoverlap', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('ddboundary', 'dirichlet');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').set('hybridvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('ds').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i2').create('dd2', 'DomainDecomposition');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('prefun', 'ddhyb');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('ndom', 1);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('dompernodemaxactive', false);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('ddolhandling', 'ddrestricted');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('usecoarse', 'aggregation');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('maxcoarsedofactive', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('maxcoarsedof', 10000);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('overlap', 1);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('meshoverlap', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('ddboundary', 'dirichlet');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').set('hybridvar', {'comp1_vef_Te_1'});
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('ds').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('ds').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('ds').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('dd2').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.probe('bnd1').genResult('none');

model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (vef)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 21, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Pressure (vef)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 21, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').label('Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('expr', 'p');
model.result('pg3').feature('con1').set('number', 40);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('smooth', 'internal');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg2').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;

model.view('view1').set('locked', true);
model.view('view1').axis.set('xmin', -2);
model.view('view1').axis.set('xmax', 6);
model.view('view1').axis.set('ymin', -4);
model.view('view1').axis.set('ymax', 4);

model.result('pg2').run;
model.result('pg2').set('view', 'view1');
model.result('pg2').setIndex('looplevel', 15, 0);
model.result('pg2').set('edges', false);
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'vef.Te_1xx');
model.result('pg2').feature('con1').set('descr', 'Viscoelastic extra stress tensor, branch 1, xx-component');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('colortable', 'GrayScale');
model.result('pg2').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([7 12 13]);
model.result('pg4').feature('lngr1').set('expr', 'vef.Te_1xx');
model.result('pg4').feature('lngr1').set('descr', 'Viscoelastic extra stress tensor, branch 1, xx-component');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevelinput', 'manual', 0);
model.result('pg4').setIndex('looplevel', [15], 0);
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0);
model.result('pg4').set('xmax', 6);
model.result('pg4').set('ymin', -5);
model.result('pg4').set('ymax', 115);
model.result('pg4').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Drag coefficient');
model.result('pg2').run;

model.title('Flow of Viscoelastic Fluid Past a Cylinder');

model.description('The Oldroyd-B fluid presents one of the simplest constitutive relations capable of describing the viscoelastic behavior of dilute polymeric solutions under general flow conditions. This example simulates a flow of such fluid past a cylinder between two parallel plates.');

model.label('cylinder_flow_viscoelastic.mph');

model.modelNode.label('Components');

out = model;
