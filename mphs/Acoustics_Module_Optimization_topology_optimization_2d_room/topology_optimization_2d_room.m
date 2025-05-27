function out = model
%
% topology_optimization_2d_room.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

model.param.set('f0', '34.5[Hz]');
model.param.descr('f0', 'Frequency for optimization');
model.param.set('W', '18[m]');
model.param.descr('W', 'Room width');
model.param.set('H', '9[m]');
model.param.descr('H', 'Room height');
model.param.set('dH', '1[m]');
model.param.descr('dH', 'Design domain height');
model.param.set('Rob', '1[m]');
model.param.descr('Rob', 'Objective domain radius');
model.param.set('xob', '16[m]');
model.param.descr('xob', 'Objective domain x-coordinate');
model.param.set('yob', '2[m]');
model.param.descr('yob', 'Objective domain y-coordinate');
model.param.set('rho1', '1.204[kg/m^3]');
model.param.descr('rho1', 'Air density');
model.param.set('K1', '141.921e3[Pa]');
model.param.descr('K1', 'Air bulk modulus');
model.param.set('rho2', '2643.0[kg/m^3]');
model.param.descr('rho2', 'Aluminum density');
model.param.set('K2', '68.7[GPa]');
model.param.descr('K2', 'Aluminum bulk modulus');
model.param.set('volfrac', '0.85');
model.param.descr('volfrac', 'Design domain volume fraction');
model.param.set('alpha_K', '0.001');
model.param.descr('alpha_K', 'Damping coefficient');
model.param.set('hmax', '0.3');
model.param.descr('hmax', 'Maximum element size');
model.param.set('rmin', '0.1*hmax');
model.param.descr('rmin', 'Minimum element size');
model.param.set('beta', '32');
model.param.descr('beta', 'Projection slope');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W' 'H'});
model.geom('geom1').feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'dH', 0);
model.geom('geom1').feature('r1').set('layerbottom', false);
model.geom('geom1').feature('r1').set('layertop', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'Rob');
model.geom('geom1').feature('c1').set('pos', {'xob' 'yob'});
model.geom('geom1').feature('c1').set('selresult', true);
model.geom('geom1').run('c1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 2, 0);
model.geom('geom1').feature('pt1').setIndex('p', 2, 1);
model.geom('geom1').feature('pt1').set('selresult', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Design Domain');
model.geom('geom1').feature('boxsel1').set('ymin', 'H-dH/2');
model.geom('geom1').run;

model.physics('acpr').feature('fpam1').set('LinearElasticOption', 'Krho');
model.physics('acpr').feature('fpam1').set('K_eff_mat', 'userdef');
model.physics('acpr').feature('fpam1').set('K_eff', 'K1*(1+alpha_K*i)');
model.physics('acpr').feature('fpam1').set('rho_mat', 'userdef');
model.physics('acpr').feature('fpam1').set('rho', 'rho1');
model.physics('acpr').create('mls1', 'FrequencyMonopoleLineSource', 0);
model.physics('acpr').feature('mls1').selection.named('geom1_pt1_pnt');
model.physics('acpr').feature('mls1').set('QsperLength', 0.02);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_boxsel1');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'hmax/2');
model.mesh('mesh1').feature('ftri1').create('size2', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size2').selection.geom('geom1', 0);
model.mesh('mesh1').feature('ftri1').feature('size2').selection.named('geom1_pt1_pnt');
model.mesh('mesh1').feature('ftri1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size2').set('hmax', '0.1*hmax');
model.mesh('mesh1').feature('size').set('hmax', 'hmax');
model.mesh('mesh1').run;

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').label('Objective Function');
model.probe('dom1').set('probename', 'obj');
model.probe('dom1').selection.named('geom1_c1_dom');
model.probe('dom1').set('expr', '0.5*realdot(p,p)/acpr.pref_SPL^2');

model.study('std1').feature('freq').set('plist', 'range(24,0.1,42)');
model.study('std1').feature('freq').set('probesel', 'none');
model.study('std1').label('Study 1 - Initial Design');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(24,0.1,42)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('p1').set('probes', {'dom1'});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 181, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 181, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 106, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevel', 106, 0);
model.result('pg2').run;
model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').label('Study 1 - Initial Design');

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').selection.named('geom1_boxsel1');
model.common('dtopo1').set('filterLengthType', 'Custom');
model.common('dtopo1').set('L_min', 'hmax');
model.common('dtopo1').set('millingActive', 'Enabled');
model.common('dtopo1').setIndex('mil_yVector', -1, 0);
model.common('dtopo1').set('projectionType', 'TanhProjection');
model.common('dtopo1').set('beta', 'beta');
model.common('dtopo1').set('interpolationType', 'Linear_interp');
model.common('dtopo1').set('discretization', 'constant');
model.common('dtopo1').set('theta_0', '1');
model.common.create('ftopobm1', 'MaterialTopologyBoundary', 'comp1');
model.common('ftopobm1').selection.set([4]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Design Domain Variables');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('geom1_boxsel1');
model.variable('var1').set('rhod_inv', '1/(1/rho2+dtopo1.theta_p*(1/rho1-1/rho2))');
model.variable('var1').descr('rhod_inv', 'Design domain density');
model.variable('var1').set('Kd_inv', '1/(1/K2+dtopo1.theta_p*(1/K1-1/K2))');
model.variable('var1').descr('Kd_inv', 'Design domain bulk modulus');

model.physics('acpr').create('fpam2', 'FrequencyPressureAcousticsModel', 2);
model.physics('acpr').feature('fpam2').label('Pressure Acoustics (Design Domain)');
model.physics('acpr').feature('fpam2').selection.named('geom1_boxsel1');
model.physics('acpr').feature('fpam2').set('LinearElasticOption', 'Krho');
model.physics('acpr').feature('fpam2').set('K_eff_mat', 'userdef');
model.physics('acpr').feature('fpam2').set('K_eff', 'Kd_inv*(1+alpha_K*i)');
model.physics('acpr').feature('fpam2').set('rho_mat', 'userdef');
model.physics('acpr').feature('fpam2').set('rho', 'rhod_inv');

model.study('std1').feature('freq').set('useadvanceddisable', true);
model.study('std1').feature('freq').set('disabledphysics', {'acpr/fpam2'});
model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std2').feature('freq').set('plist', 'f0');
model.study('std2').create('topo', 'TopologyOptimization');
model.study('std2').feature('topo').set('mmamaxiter', 50);
model.study('std2').feature('topo').set('optobj', {'comp1.obj'});
model.study('std2').feature('topo').set('descr', {'Objective Function'});
model.study('std2').feature('topo').setIndex('optobj', 'log10(comp1.obj)', 0);
model.study('std2').feature('topo').setIndex('descr', 'Objective Domain SPL', 0);
model.study('std2').feature('topo').set('constraintExpression', {'comp1.dtopo1.theta_avg'});
model.study('std2').feature('topo').setIndex('constraintExpression', 'comp1.dtopo1.theta_avg', 0);
model.study('std2').feature('topo').setIndex('constraintLbound', '', 0);
model.study('std2').feature('topo').setIndex('constraintUbound', '', 0);
model.study('std2').feature('topo').setIndex('constraintLbound', 'volfrac', 0);
model.study('std2').feature('topo').set('probesel', 'none');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_m1').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_m1').set('scaleval', '1');
model.sol('sol2').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('o1', 'Optimization');
model.sol('sol2').feature('o1').set('control', 'topo');
model.sol('sol2').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol2').feature('o1').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('o1').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('o1').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('o1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('o1').feature('s1').set('control', 'freq');
model.sol('sol2').feature('o1').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('o1').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('o1').feature('s1').set('control', 'freq');
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('o1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('o1').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('o1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('o1').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runFromTo('st1', 'v1');

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').set('showlegendsunit', true);
model.result('pg3').label('Acoustic Pressure (acpr) 1');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg4').feature('surf1').set('colortable', 'Rainbow');
model.result('pg4').feature('surf1').set('colorscalemode', 'linear');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').label('Sound Pressure Level (acpr) 1');

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').label('Topology Optimization');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg4');
model.nodeGroup.move('grp2', 2);

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Output material volume factor');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Threshold');

model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').add('plotgroup', 'pg6');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset2');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg5').feature('surf1').set('rangecoloractive', true);
model.result('pg5').feature('surf1').set('colortabletrans', 'none');
model.result('pg5').feature('surf1').set('rangecolormin', 0);
model.result('pg5').feature('surf1').set('rangecolormax', 1);
model.result('pg6').set('data', 'filt1');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', '1');
model.result('pg6').feature('surf1').set('coloring', 'uniform');
model.result('pg6').feature('surf1').set('color', 'gray');
model.result('pg6').feature('surf1').set('titletype', 'none');
model.result('pg3').run;

model.nodeGroup('grp2').add('plotgroup', 'pg4');
model.nodeGroup('grp2').add('plotgroup', 'pg3');
model.nodeGroup('grp2').label('Study 2 - Topology Optimization');

model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'acpr.Lp_t');
model.result('pg6').feature('surf1').set('descr', 'Total sound pressure level');
model.result('pg6').feature('surf1').set('coloring', 'colortable');

model.study('std2').feature('topo').set('plot', true);
model.study('std2').feature('topo').set('plotgroup', 'pg6');

model.sol('sol2').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('o1').feature('s1').feature('se1').set('segterm', 'iter');
model.sol('sol2').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').label('Optimization');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ssDef').set('segvar', {'comp1_dtopo1_theta_c' 'comp1_dtopo1_theta_f'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').label('Milling');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_dtopo1_theta_m1'});
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss2').label('Acoustics');
model.sol('sol2').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_p'});

model.study('std2').label('Study 2 - Topology Optimization');
model.study('std2').setGenPlots(false);
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'f0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'Hz', 0);
model.study('std2').feature('param').setIndex('pname', 'f0', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'Hz', 0);
model.study('std2').feature('param').setIndex('pname', 'beta', 0);
model.study('std2').feature('param').setIndex('plistarr', '4 8 16 32', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').set('probesel', 'none');
model.study('std2').feature('param').set('reusesol', true);

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol2');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'beta'});
model.batch('p1').set('plistarr', {'4 8 16 32'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'none');
model.batch('p1').set('probes', {'dom1'});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').run('compute');

model.result('pg3').run;

model.study('std2').feature('topo').set('probewindow', '');
model.study.create('std3');
model.study('std3').create('freq', 'Frequency');
model.study('std3').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std3').feature('freq').set('probesel', 'none');
model.study('std3').feature('freq').setEntry('activate', 'comp1:topopt', false);
model.study('std3').feature('freq').set('usesol', true);
model.study('std3').feature('freq').set('notsolmethod', 'sol');
model.study('std3').feature('freq').set('notstudy', 'std2');
model.study('std3').feature('freq').set('plist', 'range(24,0.1,42)');
model.study('std3').label('Study 3 - Optimized Spectrum');
model.study('std3').setGenPlots(false);

model.sol.create('sol8');
model.sol('sol8').study('std3');
model.sol('sol8').create('st1', 'StudyStep');
model.sol('sol8').feature('st1').set('study', 'std3');
model.sol('sol8').feature('st1').set('studystep', 'freq');
model.sol('sol8').create('v1', 'Variables');
model.sol('sol8').feature('v1').set('control', 'freq');
model.sol('sol8').create('s1', 'Stationary');
model.sol('sol8').feature('s1').set('stol', 0.001);
model.sol('sol8').feature('s1').create('p1', 'Parametric');
model.sol('sol8').feature('s1').feature.remove('pDef');
model.sol('sol8').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol8').feature('s1').feature('p1').set('plistarr', {'range(24,0.1,42)'});
model.sol('sol8').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol8').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol8').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol8').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol8').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol8').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol8').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol8').feature('s1').feature('p1').set('probes', {'dom1'});
model.sol('sol8').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol8').feature('s1').set('linpmethod', 'sol');
model.sol('sol8').feature('s1').set('linpsol', 'zero');
model.sol('sol8').feature('s1').set('control', 'freq');
model.sol('sol8').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol8').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol8').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol8').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol8').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol8').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol8').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol8').feature('s1').feature.remove('fcDef');
model.sol('sol8').attach('std3');
model.sol('sol8').runAll;

model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Response Comparison');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'SPL in Objective Domain');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').set('expr', {'obj'});
model.result('pg7').feature('glob1').set('descr', {'Objective Function'});
model.result('pg7').feature('glob1').setIndex('expr', '10*log10(obj)', 0);
model.result('pg7').feature('glob1').setIndex('unit', '', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Initial Design', 0);
model.result('pg7').feature('glob1').set('linewidth', 2);
model.result('pg7').feature.duplicate('glob2', 'glob1');
model.result('pg7').run;
model.result('pg7').feature('glob2').set('data', 'dset5');
model.result('pg7').feature('glob2').setIndex('expr', '10*log10(obj)', 0);
model.result('pg7').feature('glob2').setIndex('unit', '', 0);
model.result('pg7').feature('glob2').setIndex('descr', 'Topology Optimization', 0);
model.result.dataset('filt1').set('expr', 'if(isdefined(dtopo1.theta_m), dtopo1.theta_m, 1)');
model.result.dataset('filt1').set('smooth', 'material');
model.result.dataset('filt1').set('useder', true);
model.result.dataset('filt1').createMeshPart('mcomp1', 'mgeom1', 'mpart1', 'imp1');

model.mesh('mpart1').feature('imp1').importData;
model.mesh('mpart1').run;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('mesh', 'mpart1');
model.geom('geom2').run('imp1');

model.physics.create('acpr2', 'PressureAcoustics', 'geom2');
model.physics('acpr2').model('comp2');

model.study('std1').feature('freq').setSolveFor('/physics/acpr2', false);
model.study('std2').feature('freq').setSolveFor('/physics/acpr2', false);
model.study('std3').feature('freq').setSolveFor('/physics/acpr2', false);

model.geom('geom2').run;

model.physics('acpr2').feature('fpam1').set('LinearElasticOption', 'Krho');
model.physics('acpr2').feature('fpam1').set('K_eff_mat', 'userdef');
model.physics('acpr2').feature('fpam1').set('K_eff', 'K1*(1+alpha_K*i)');
model.physics('acpr2').feature('fpam1').set('rho_mat', 'userdef');
model.physics('acpr2').feature('fpam1').set('rho', 'rho1');
model.physics('acpr2').create('mls1', 'FrequencyMonopoleLineSource', 0);
model.physics('acpr2').feature('mls1').selection.named('geom2_imp1_mpart1_imp1_geom1_pt1_pnt');
model.physics('acpr2').feature('mls1').set('QsperLength', 0.02);

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').create('size1', 'Size');
model.mesh('mesh2').feature('ftri1').feature('size1').selection.geom('geom2', 0);
model.mesh('mesh2').feature('ftri1').feature('size1').selection.named('geom2_imp1_mpart1_imp1_geom1_pt1_pnt');
model.mesh('mesh2').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmax', '0.1*hmax');
model.mesh('mesh2').feature('size').set('hmax', 'hmax');
model.mesh('mesh2').run;

model.probe.create('dom2', 'Domain');
model.probe('dom2').model('comp2');
model.probe('dom2').set('intsurface', true);
model.probe('dom2').set('intvolume', true);
model.probe('dom2').label('Objective Function');
model.probe('dom2').set('probename', 'obj');
model.probe('dom2').selection.named('geom2_imp1_mpart1_imp1_geom1_c1_dom');
model.probe('dom2').set('expr', '0.5*realdot(p2,p2)/acpr2.pref_SPL^2');

model.study.create('std4');
model.study('std4').create('freq', 'Frequency');
model.study('std4').feature('freq').setSolveFor('/physics/acpr', false);
model.study('std4').feature('freq').setSolveFor('/physics/acpr2', true);
model.study('std4').feature('freq').set('probesel', 'none');
model.study('std4').feature('freq').setEntry('activate', 'comp1:topopt', false);
model.study('std4').feature('freq').set('plist', 'range(24,0.1,42)');
model.study('std4').label('Study 4 - Verification');

model.sol.create('sol9');
model.sol('sol9').study('std4');
model.sol('sol9').create('st1', 'StudyStep');
model.sol('sol9').feature('st1').set('study', 'std4');
model.sol('sol9').feature('st1').set('studystep', 'freq');
model.sol('sol9').create('v1', 'Variables');
model.sol('sol9').feature('v1').set('control', 'freq');
model.sol('sol9').create('s1', 'Stationary');
model.sol('sol9').feature('s1').set('stol', 0.001);
model.sol('sol9').feature('s1').create('p1', 'Parametric');
model.sol('sol9').feature('s1').feature.remove('pDef');
model.sol('sol9').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol9').feature('s1').feature('p1').set('plistarr', {'range(24,0.1,42)'});
model.sol('sol9').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol9').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol9').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol9').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol9').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol9').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol9').feature('s1').feature('p1').set('probesel', 'none');
model.sol('sol9').feature('s1').feature('p1').set('probes', {'dom1' 'dom2'});
model.sol('sol9').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol9').feature('s1').set('linpmethod', 'sol');
model.sol('sol9').feature('s1').set('linpsol', 'zero');
model.sol('sol9').feature('s1').set('control', 'freq');
model.sol('sol9').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol9').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol9').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol9').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol9').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol9').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol9').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol9').feature('s1').feature.remove('fcDef');
model.sol('sol9').attach('std4');
model.sol('sol9').runAll;

model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset7');
model.result('pg8').setIndex('looplevel', 181, 0);
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', {'acpr2.p_t'});
model.result('pg8').feature('surf1').set('colortable', 'Wave');
model.result('pg8').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg8').set('showlegendsunit', true);
model.result('pg8').label('Acoustic Pressure (acpr2)');
model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').set('data', 'dset7');
model.result('pg9').setIndex('looplevel', 181, 0);
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', {'acpr2.Lp_t'});
model.result('pg9').feature('surf1').set('colortable', 'Rainbow');
model.result('pg9').feature('surf1').set('colorscalemode', 'linear');
model.result('pg9').set('showlegendsunit', true);
model.result('pg9').label('Sound Pressure Level (acpr2)');

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').label('Topology Optimization');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup('grp3').placeAfter('plotgroup', 'pg9');
model.nodeGroup.move('grp3', 3);

model.result.create('pg10', 'PlotGroup2D');
model.result('pg10').label('Output material volume factor 1');
model.result.create('pg11', 'PlotGroup2D');
model.result('pg11').label('Threshold 1');

model.nodeGroup('grp3').add('plotgroup', 'pg10');
model.nodeGroup('grp3').add('plotgroup', 'pg11');

model.result.dataset.create('filt2', 'Filter');
model.result.dataset('filt2').label('Filter 1');
model.result.dataset('filt2').set('data', 'dset6');
model.result.dataset('filt2').set('expr', 'dtopo1.theta');
model.result.dataset('filt2').set('lowerexpr', '0.5');
model.result.dataset('filt2').set('smooth', 'none');
model.result.dataset('filt2').set('useder', false);
model.result('pg10').set('data', 'dset6');
model.result('pg10').create('surf1', 'Surface');
model.result('pg10').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg10').feature('surf1').set('rangecoloractive', true);
model.result('pg10').feature('surf1').set('colortabletrans', 'none');
model.result('pg10').feature('surf1').set('rangecolormin', 0);
model.result('pg10').feature('surf1').set('rangecolormax', 1);
model.result('pg11').set('data', 'filt2');
model.result('pg11').create('surf1', 'Surface');
model.result('pg11').feature('surf1').set('expr', '1');
model.result('pg11').feature('surf1').set('coloring', 'uniform');
model.result('pg11').feature('surf1').set('color', 'gray');
model.result('pg11').feature('surf1').set('titletype', 'none');
model.result('pg8').run;

model.nodeGroup.remove('grp3');

model.result('pg8').run;

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup('grp3').placeAfter('plotgroup', 'pg7');
model.nodeGroup('grp3').add('plotgroup', 'pg8');
model.nodeGroup('grp3').add('plotgroup', 'pg9');
model.nodeGroup('grp3').label('Study 4 - Verification');

model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 106, 0);
model.result('pg8').run;
model.result('pg9').run;
model.result('pg9').setIndex('looplevel', 106, 0);
model.result('pg9').run;
model.result('pg7').run;
model.result('pg7').feature.duplicate('glob3', 'glob2');
model.result('pg7').run;
model.result('pg7').feature('glob3').set('data', 'dset7');
model.result('pg7').feature('glob3').setIndex('expr', '10*log10(obj)', 0);
model.result('pg7').feature('glob3').setIndex('unit', '', 0);
model.result('pg7').feature('glob3').setIndex('descr', 'Sound Hard Boundaries', 0);
model.result('pg7').feature.duplicate('glob4', 'glob3');
model.result('pg7').run;
model.result('pg7').feature('glob4').setIndex('expr', '10*log10(obj)', 0);
model.result('pg7').feature('glob4').setIndex('unit', '', 0);
model.result('pg7').feature('glob4').setIndex('descr', 'Optimization Frequency', 0);
model.result('pg7').feature('glob4').set('xdata', 'expr');
model.result('pg7').feature('glob4').set('xdataexpr', 'f0');
model.result('pg7').feature('glob4').set('linecolor', 'black');
model.result('pg7').run;

model.title('Topology Optimization and Verification of an Acoustic Mode in a 2D Room');

model.description('This tutorial introduces the use of topology optimization in acoustics. The goal of the optimization is to find the optimal material distribution (solid or air) in a given design domain, here the ceiling of a 2D room, that minimizes the average sound pressure level in an objective region. The optimization is carried out for a single frequency. The topology optimized design is further transformed into a geometry and the results of the optimization are verified using sound hard boundaries.');

model.mesh('mesh1').clearMesh;
model.mesh('mpart1').clearMesh;
model.mesh('mesh2').clearMesh;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;

model.label('topology_optimization_2d_room.mph');

model.modelNode.label('Components');

out = model;
