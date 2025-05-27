function out = model
%
% twophase_flow_column.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics('dl').field('pressure').field('p_w');
model.physics.create('dl2', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl2').model('comp1');
model.physics('dl2').field('pressure').field('p_nw');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/dl', true);
model.study('std1').feature('time').setSolveFor('/physics/dl2', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rho_water', '1000[kg/m^3]', 'Density, water');
model.param.set('mu_water', '1e-3[Pa*s]', 'Dynamic viscosity, water');
model.param.set('rho_air', '1.28[kg/m^3]', 'Density, air');
model.param.set('mu_air', '1.81e-5[Pa*s]', 'Dynamic viscosity, air');
model.param.set('rho_oil', '800[kg/m^3]', 'Density, oil');
model.param.set('mu_oil', '3.92e-3[Pa*s]', 'Dynamic viscosity, oil');
model.param.set('sigma_aw', '0.0681[H/m]', 'Interfacial tension, air-water');
model.param.set('sigma_ow', '0.0364[H/m]', 'Interfacial tension, oil-water');

model.func.create('int1', 'Interpolation');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'twophase_flow_column_interpolation.txt');
model.func('int1').importData;
model.func('int1').setIndex('fununit', 'm', 0);
model.func('int1').setIndex('argunit', 'h', 0);
model.func('int1').set('funcname', 'Hp_nw_t');
model.func('int1').label('Inlet Air Pressure Head');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.06 0.0834]);
model.geom('geom1').feature('r1').setIndex('layer', 0.0074, 0);
model.geom('geom1').runPre('fin');

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('smoothzonelocactive', true);
model.func('rm1').set('smoothzoneloc', '1e-3');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').label('Air-Water Experiment');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('rho_w', 'rho_water', 'Density, wetting fluid');
model.variable('var1').set('mu_w', 'mu_water', 'Dynamic viscosity, wetting fluid');
model.variable('var1').set('rho_nw', 'rho_air', 'Density, nonwetting fluid');
model.variable('var1').set('mu_nw', 'mu_air', 'Dynamic viscosity, nonwetting fluid');
model.variable('var1').set('alpha', '1.89[1/m]', 'Van Genuchten alpha parameter');
model.variable('var1').set('L', '0.5', 'Van Genuchten L parameter');
model.variable('var1').set('N', '2.811', 'Van Genuchten N parameter, air-water');
model.variable('var1').set('M', '1-1/N', 'Van Genuchten M parameter');
model.variable('var1').set('kap_su', '2480[mD]', 'Permeability, upper layer');
model.variable('var1').set('theta_ru', '0.021', 'Residual volume fraction, upper layer');
model.variable('var1').set('sigma', '1', 'Ratio between interfacial tensions ');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Van Genuchten Retention Model');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('p_c', 'p_nw-p_w', 'Capillary pressure');
model.variable('var2').set('Hc', 'p_c/(rho_w*g_const)', 'Capillary pressure head');
model.variable('var2').set('Se_w', '(1+(alpha*rm1(Hc[1/m])[m])^N)^(-M)', 'Effective saturation, wetting phase');
model.variable('var2').set('Se_nw', '1-Se_w', 'Effective saturation, nonwetting phase');
model.variable('var2').set('theta_w', 'theta_r+Se_w*(theta_s-theta_r)', 'Volume fraction, wetting phase');
model.variable('var2').set('theta_nw', 'theta_s-theta_w', 'Volume fraction, nonwetting phase');
model.variable('var2').set('kr_w', '(Se_w^L*(1-(1-Se_w^(1/M))^M)^2)+eps', 'Relative permeability, wetting phase');
model.variable('var2').set('kr_nw', '((1-Se_w)^L*(1-Se_w^(1/M))^(2*M))+eps', 'Relative permeability, nonwetting phase');
model.variable('var2').set('Cp', '((alpha*M/(1-M)*(theta_s-theta_r)*Se_w^(1/M)*(1-Se_w^(1/M))^M))/(rho_w*g_const)', 'Specific capacity');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Initial and Boundary Conditions');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('p_nw_top', 'Hp_nw_t(t)*rho_w*g_const*sigma');
model.variable('var3').set('p_nw_init', 'p_nw_top+(8.34[cm]-y)*rho_nw*g_const');
model.variable('var3').set('p_w_init', '-rho_w*g_const*y');
model.variable('var3').set('p_w0', '0.1[m]*sigma*rho_w*g_const*(t/170[h])');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Lower Layer');
model.variable('var4').selection.geom('geom1', 2);
model.variable('var4').selection.set([1]);

% To import content from file, use:
% model.variable('var4').loadFile('FILENAME');
model.variable('var4').set('kap_s', '13.57[mD]', 'Permeability, lower layer');
model.variable('var4').set('theta_s', '0.5', 'Saturated volume fraction, lower layer');
model.variable('var4').set('theta_r', '0', 'Residual volume fraction, lower layer');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').label('Upper Layer');
model.variable('var5').selection.geom('geom1', 2);
model.variable('var5').selection.set([2]);

% To import content from file, use:
% model.variable('var5').loadFile('FILENAME');
model.variable('var5').set('kap_s', 'kap_su', 'Permeability, upper layer');
model.variable('var5').set('theta_s', '0.32', 'Saturated volume fraction, upper layer');
model.variable('var5').set('theta_r', 'theta_ru', 'Residual volume fraction, upper layer');

model.physics('dl').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl').feature('porous1').feature('fluid1').set('rho_mat', 'userdef');
model.physics('dl').feature('porous1').feature('fluid1').set('rho', 'rho_w');
model.physics('dl').feature('porous1').feature('fluid1').set('mu_mat', 'userdef');
model.physics('dl').feature('porous1').feature('fluid1').set('mu', 'mu_w');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('epsilon', 0.25);
model.physics('dl').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl').feature('porous1').feature('pm1').set('kappa', {'kap_s' '0' '0' '0' 'kap_s' '0' '0' '0' 'kap_s'});
model.physics('dl').feature.duplicate('porous2', 'porous1');
model.physics('dl').feature('porous2').selection.set([2]);
model.physics('dl').feature('porous2').set('storageModelType', 'userdef');
model.physics('dl').feature('porous2').set('Sp', 'Cp');
model.physics('dl').feature('porous2').feature('pm1').set('kappa', {'kap_s*kr_w' '0' '0' '0' 'kap_s*kr_w' '0' '0' '0' 'kap_s*kr_w'});
model.physics('dl').feature('init1').set('p', 'p_w_init');
model.physics('dl').create('pr1', 'Pressure', 1);
model.physics('dl').feature('pr1').selection.set([2]);
model.physics('dl').feature('pr1').set('p0', 'p_w0');
model.physics('dl').create('ms1', 'MassSource', 2);
model.physics('dl').feature('ms1').selection.set([2]);
model.physics('dl').feature('ms1').set('Qm', 'Cp*p_nwt*rho_w');
model.physics('dl2').selection.set([2]);
model.physics('dl2').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl2').feature('porous1').set('storageModelType', 'userdef');
model.physics('dl2').feature('porous1').set('Sp', 'Cp');
model.physics('dl2').feature('porous1').feature('fluid1').set('rho_mat', 'userdef');
model.physics('dl2').feature('porous1').feature('fluid1').set('rho', 'rho_nw');
model.physics('dl2').feature('porous1').feature('fluid1').set('mu_mat', 'userdef');
model.physics('dl2').feature('porous1').feature('fluid1').set('mu', 'mu_nw');
model.physics('dl2').feature('porous1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl2').feature('porous1').feature('pm1').set('epsilon', 0.25);
model.physics('dl2').feature('porous1').feature('pm1').set('kappa_mat', 'userdef');
model.physics('dl2').feature('porous1').feature('pm1').set('kappa', {'kap_s*kr_nw' '0' '0' '0' 'kap_s*kr_nw' '0' '0' '0' 'kap_s*kr_nw'});
model.physics('dl2').feature('init1').set('p', 'p_nw_init');
model.physics('dl2').create('pr1', 'Pressure', 1);
model.physics('dl2').feature('pr1').selection.set([5]);
model.physics('dl2').feature('pr1').set('p0', 'p_nw_top');
model.physics('dl2').create('ms1', 'MassSource', 2);
model.physics('dl2').feature('ms1').selection.set([2]);
model.physics('dl2').feature('ms1').set('Qm', 'Cp*p_wt*rho_nw');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').run;

model.study('std1').label('Air-Water');
model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', '0 0.001 0.01 0.1 range(1,170)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 0.001 0.01 0.1 range(1,170)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', '0 0 0');
model.result.dataset('cpt1').set('pointy', '0.075 0.045 0.015');
model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Inlet Air Pressure and Capillary Pressure, Air-Water');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'time[h]');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Inlet air pressure head (solid line) and capillary pressure head (dashed lines)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([6]);
model.result('pg1').feature('ptgr1').set('expr', 'Hp_nw_t(t)');
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'Inlet pressure head, top boundary', 0);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').set('expr', 'Hc');
model.result('pg1').feature('ptgr2').set('descr', 'Capillary pressure head');
model.result('pg1').feature('ptgr2').set('linestyle', 'dashed');
model.result('pg1').feature('ptgr2').set('legendmethod', 'automatic');
model.result('pg1').feature('ptgr2').set('autopoint', false);
model.result('pg1').feature('ptgr2').set('autodescr', true);
model.result('pg1').feature('ptgr2').set('legendsuffix', ', top boundary');
model.result('pg1').run;
model.result('pg1').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg1').run;
model.result('pg1').feature('ptgr3').set('data', 'cpt1');
model.result('pg1').feature('ptgr3').set('autopoint', true);
model.result('pg1').feature('ptgr3').set('autodescr', false);
model.result('pg1').feature('ptgr3').set('legendsuffix', '');
model.result('pg1').feature('ptgr3').set('legendprefix', 'Capillary pressure head, ');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Relative Permeabilities at 3 Points');
model.result('pg2').set('data', 'cpt1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Relative permeability for wetting (solid lines) and nonwetting (dashed) fluids at different points');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'time [h]');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').set('expr', 'kr_w');
model.result('pg2').feature('ptgr1').set('descr', 'Relative permeability, wetting phase');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autoexpr', true);
model.result('pg2').run;
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').set('expr', 'kr_nw');
model.result('pg2').feature('ptgr2').set('descr', 'Relative permeability, nonwetting phase');
model.result('pg2').feature('ptgr2').set('linestyle', 'dashed');
model.result('pg2').feature('ptgr2').set('linecolor', 'cyclereset');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 4, 0);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'Se_nw');
model.result('pg3').feature('surf1').set('descr', 'Effective saturation, nonwetting phase');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').label('Effective Saturation, Nonwetting Phase');

model.variable.create('var6');
model.variable('var6').model('comp1');
model.variable('var6').label('Air-Oil Experiment');

% To import content from file, use:
% model.variable('var6').loadFile('FILENAME');
model.variable('var6').set('rho_w', 'rho_oil', 'Density, wetting fluid');
model.variable('var6').set('mu_w', 'mu_oil', 'Dynamic viscosity, wetting fluid');
model.variable('var6').set('rho_nw', 'rho_air', 'Density, nonwetting fluid');
model.variable('var6').set('mu_nw', 'mu_air', 'Dynamic viscosity, nonwetting fluid');
model.variable('var6').set('alpha', '3.58[1/m]', 'Van Genuchten alpha parameter');
model.variable('var6').set('L', '0.5', 'Van Genuchten L parameter');
model.variable('var6').set('N', '3.1365', 'Van Genuchten N parameter');
model.variable('var6').set('M', '1-1/N', 'Van Genuchten M parameter');
model.variable('var6').set('kap_su', '1104.41[mD]', 'Permeability, upper layer');
model.variable('var6').set('theta_ru', '0.0072', 'Residual volume fraction, upper layer');
model.variable('var6').set('sigma_ao', '0.0259[H/m]', 'Interfacial tension air-oil');
model.variable('var6').set('sigma', 'sigma_ao/sigma_aw', 'Ratio between interfacial tensions');
model.variable.create('var7');
model.variable('var7').model('comp1');
model.variable('var7').label('Oil-Water Experiment');

% To import content from file, use:
% model.variable('var7').loadFile('FILENAME');
model.variable('var7').set('rho_w', 'rho_water', 'Density, wetting fluid');
model.variable('var7').set('mu_w', 'mu_water', 'Dynamic viscosity, wetting fluid');
model.variable('var7').set('rho_nw', 'rho_oil', 'Density, nonwetting fluid');
model.variable('var7').set('mu_nw', 'mu_oil', 'Dynamic viscosity, nonwetting fluid');
model.variable('var7').set('alpha', '3.58[1/m]', 'Van Genuchten alpha parameter');
model.variable('var7').set('L', '0.5', 'van Genuchten L parameter');
model.variable('var7').set('N', '3.1365', 'van Genuchten N parameter');
model.variable('var7').set('M', '1-1/N', 'van Genuchten M parameter');
model.variable('var7').set('kap_su', '952.45[mD]', 'Permeability, upper layer');
model.variable('var7').set('theta_ru', '0.0072', 'Residual volume fraction, upper layer');
model.variable('var7').set('sigma_ow', '0.0364[H/m]', 'Interfacial tension');
model.variable('var7').set('sigma', 'sigma_ow/sigma_aw', 'Ratio between interfacial tensions');

model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledvariables', {'var6' 'var7'});
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/dl', true);
model.study('std2').feature('time').setSolveFor('/physics/dl2', true);
model.study('std2').label('Air-Oil');
model.study('std2').setGenPlots(false);
model.study('std2').feature('time').set('tunit', 'h');
model.study('std2').feature('time').set('tlist', '0 0.001 0.01 0.1 range(1,170)');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledvariables', {'var1' 'var7'});

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', '0 0.001 0.01 0.1 range(1,170)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.005);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('stabcntrl', true);
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset.duplicate('cpt2', 'cpt1');
model.result.dataset('cpt2').set('data', 'dset2');
model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('Inlet Air Pressure and Capillary Pressure, Air-Oil');
model.result('pg4').set('data', 'dset2');
model.result('pg4').run;
model.result('pg4').feature('ptgr1').set('expr', 'Hp_nw_t(t)*sigma');
model.result('pg4').run;
model.result('pg4').feature('ptgr3').set('data', 'cpt2');
model.result('pg4').run;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/dl', true);
model.study('std3').feature('time').setSolveFor('/physics/dl2', true);
model.study('std3').label('Oil-Water');
model.study('std3').setGenPlots(false);
model.study('std3').feature('time').set('tunit', 'h');
model.study('std3').feature('time').set('tlist', '0 0.001 0.01 0.1 range(1,170)');
model.study('std3').feature('time').set('useadvanceddisable', true);
model.study('std3').feature('time').set('disabledvariables', {'var1' 'var6'});

model.sol.create('sol3');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([2]);

model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', '0 0.001 0.01 0.1 range(1,170)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 0.005);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('maxorder', 2);
model.sol('sol3').feature('t1').set('stabcntrl', true);
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('seDef', 'Segregated');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol3').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol3').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol3').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol3').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').feature('d1').label('Direct, pressure (dl) (Merged)');
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol3').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol3').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol3').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol3').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol3').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol3').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol3').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol3').feature('t1').feature('fc1').set('aaccdelay', 1);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').feature('t1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset.duplicate('cpt3', 'cpt2');
model.result.dataset('cpt3').set('data', 'dset3');
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Inlet Air Pressure and Capillary Pressure, Oil-Water');
model.result('pg5').set('data', 'dset3');
model.result('pg5').run;
model.result('pg5').feature('ptgr3').set('data', 'cpt3');
model.result('pg5').run;

model.title('Two-Phase Flow in Column');

model.description('This example describes the simultaneous flow of two immiscible fluids in porous media in a multistep inlet pressure experiment. Model solves for the pressure and the degree saturation for the air and water within a representative volume and so track saturation levels rather than estimating a discrete location for the air-water interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('twophase_flow_column.mph');

model.modelNode.label('Components');

out = model;
