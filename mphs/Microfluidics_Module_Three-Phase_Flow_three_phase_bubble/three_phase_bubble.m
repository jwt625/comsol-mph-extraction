function out = model
%
% three_phase_bubble.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Microfluidics_Module/Three-Phase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('terpf', 'TernaryPhaseField', 'geom1');
model.physics('terpf').model('comp1');

model.multiphysics.create('tfpf1', 'TernaryFlowPhaseField', 'geom1', 2);
model.multiphysics('tfpf1').set('Fluid_physics', 'spf');
model.multiphysics('tfpf1').set('MovingInterface_physics', 'terpf');
model.multiphysics('tfpf1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/terpf', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/tfpf1', true);

model.geom('geom1').lengthUnit('cm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('sigma_AB', '0.05[N/m]', 'Surface tension coefficient between the interface of two fluids');
model.param.set('sigma_AC', '0.07[N/m]', 'Surface tension coefficient between the interface of light fluid and gas');
model.param.set('sigma_BC', '0.07[N/m]', 'Surface tension coefficient between the interface of heavy fluid and gas');
model.param.set('mu_A', '0.1[Pa*s]', 'Dynamic viscosity of liquid');
model.param.set('mu_B', '0.15[Pa*s]', 'Dynamic viscosity of gas');
model.param.set('mu_C', '1e-4[Pa*s]', 'Dynamic viscosity of gas');
model.param.set('width', '3.2[cm]', 'Width of container');
model.param.set('height', '14[cm]', 'Height of container');
model.param.set('radius', '0.8[cm]', 'Radius of bubble');
model.param.set('center_rec', '5.5[cm]', 'Center of container');
model.param.set('line_z', '2[cm]', 'Location of interface of liquid layers');
model.param.set('center_bub', '0.15[cm]', 'Center of gas bubble');
model.param.set('rho_A', '1000[kg/m^3]', 'Density of light fluid');
model.param.set('rho_B', '1200[kg/m^3]', 'Density of heavy fluid');
model.param.set('rho_C', '1[kg/m^3]', 'Density of gas');
model.param.set('tend', '0.65[s]', 'Simulation time period');
model.param.set('delta_t', '0.025[s]', 'Time interface for saving');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('M0', 'M0const*nojac(M0factor)', 'Mobility turning parameter');
model.variable('var1').set('M0factor', 'phiA^2*phiB^2+terpf.phiC^2*phiA^2+terpf.phiC^2*phiB^2', 'Help variable');
model.variable('var1').set('M0const', '2e-5[m^3/s]', 'Help variable');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'width/2' 'height'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', {'width/4' 'center_rec'});
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'radius');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', {'0' 'center_bub'});
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'line_z', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'radius*2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'line_z', 1, 1);
model.geom('geom1').run('fin');

model.physics('terpf').feature('mp1').set('M0', 'M0');
model.physics('terpf').feature('mp1').set('SurfaceTensionCoefficientAB', 'userdef');
model.physics('terpf').feature('mp1').set('sigma_AB', 'sigma_AB');
model.physics('terpf').feature('mp1').set('SurfaceTensionCoefficientBC', 'userdef');
model.physics('terpf').feature('mp1').set('sigma_BC', 'sigma_BC');
model.physics('terpf').feature('mp1').set('SurfaceTensionCoefficientAC', 'userdef');
model.physics('terpf').feature('mp1').set('sigma_AC', 'sigma_AC');
model.physics('terpf').create('init2', 'init', 2);
model.physics('terpf').feature('init2').selection.set([1]);
model.physics('terpf').feature('init2').set('phiB', 1);
model.physics('terpf').create('init3', 'init', 2);
model.physics('terpf').feature('init3').selection.set([2]);
model.physics('terpf').feature('init1').set('phiA', 1);

model.material.create('mpmat1', 'Multiphase', 'comp1');
model.material('mpmat1').selection.geom('geom1', 2);
model.material('mpmat1').selection.set([1 2 3]);
model.material('mpmat1').selection.inherit(false);
model.material('mpmat1').set('vfDefinition', 'terpf');
model.material('mpmat1').feature.create('phase2', 'PhaseLink', 'comp1');
model.material('mpmat1').feature.create('phase3', 'PhaseLink', 'comp1');
model.material('mpmat1').set('constrainedPhase', 'phase3');

model.multiphysics('tfpf1').set('multiphaseMaterialList', 'mpmat1');

model.material('mpmat1').feature('phase1').propertyGroup('def').set('density', {'rho_A'});
model.material('mpmat1').feature('phase1').propertyGroup('def').set('dynamicviscosity', {'mu_A'});
model.material('mpmat1').feature('phase1').label('Fluid A');
model.material('mpmat1').feature('phase2').label('Fluid B');
model.material('mpmat1').feature('phase2').propertyGroup('def').set('density', {'rho_B'});
model.material('mpmat1').feature('phase2').propertyGroup('def').set('dynamicviscosity', {'mu_B'});
model.material('mpmat1').feature('phase3').propertyGroup('def').set('density', {'rho_C'});
model.material('mpmat1').feature('phase3').propertyGroup('def').set('dynamicviscosity', {'mu_C'});
model.material('mpmat1').feature('phase3').label('Fluid C');

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('slope', 200);
model.func('rm1').set('cutoffactive', true);

model.physics('spf').prop('PhysicalModelProperty').set('IncludeGravity', true);
model.physics('spf').feature('grav1').set('g', {'0' '0' '-g_const*rm1(t[1/s])'});
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.set([8]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 0.04);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.025,1)*0.65');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phiB').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phiA').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phiB').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phiA').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.025,1)*0.65');
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
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_etaA' 'global' 'comp1_etaB' 'global' 'comp1_p' 'scaled' 'comp1_phiA' 'global' 'comp1_phiB' 'global'  ...
'comp1_u' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_etaA' 'factor' 'comp1_etaB' 'factor' 'comp1_p' 'factor' 'comp1_phiA' 'factor' 'comp1_phiB' 'factor'  ...
'comp1_u' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_etaA' '0.1' 'comp1_etaB' '0.1' 'comp1_p' '1' 'comp1_phiA' '0.1' 'comp1_phiB' '0.1'  ...
'comp1_u' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_u' 'comp1_p'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Velocity u, Pressure p');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_phiA' 'comp1_phiB' 'comp1_etaA' 'comp1_etaB'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, phase field variables (terpf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Phase Field Variables');
model.sol('sol1').feature('t1').feature('se1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 1);
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, phase field variables (terpf)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');

model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', '0.0005');

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');

model.sol('sol1').runFromTo('st1', 'v1');

model.result.remove('pg1');

model.study('std1').feature('time').set('plotgroup', 'Default');

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
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
model.result('pg2').setIndex('looplevel', 1, 0);
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
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pcond1/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('2D Plot Group: Phase A (terpf)');
model.result('pg4').set('dataisaxisym', 'off');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('defaultPlotID', 'TernaryFluid_PhaseField/phys1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Phase Field Variable, Phase A');
model.result('pg4').feature('surf1').set('expr', 'phiA');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('2D Plot Group: Phase B (terpf)');
model.result('pg5').set('dataisaxisym', 'off');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').set('defaultPlotID', 'TernaryFluid_PhaseField/phys1/pdef1/pcond1/pg2');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Phase Field Variable, Phase B');
model.result('pg5').feature('surf1').set('expr', 'phiB');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('2D Plot Group: Phase C (terpf)');
model.result('pg6').set('dataisaxisym', 'off');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 1, 0);
model.result('pg6').set('defaultPlotID', 'TernaryFluid_PhaseField/phys1/pdef1/pcond1/pg3');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').label('Phase Field Variable, Phase C');
model.result('pg6').feature('surf1').set('expr', 'terpf.phiC');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').label('2D Plot Group: Three Phases (terpf)');
model.result('pg7').set('dataisaxisym', 'off');
model.result('pg7').set('edges', 'off');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 1, 0);
model.result('pg7').set('defaultPlotID', 'TernaryFluid_PhaseField/phys1/pdef1/pcond1/pg4');
model.result('pg7').feature.create('surf1', 'Surface');
model.result('pg7').feature('surf1').label('Ternary Phase Field');
model.result('pg7').feature('surf1').set('expr', 'phiA+2*phiB+3*terpf.phiC');
model.result('pg7').feature('surf1').set('smooth', 'internal');
model.result('pg7').feature('surf1').set('data', 'parent');
model.result('pg1').run;

model.study('std1').feature('time').set('plotgroup', 'pg7');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg8', 'PlotGroup3D');
model.result('pg8').run;
model.result('pg8').create('iso1', 'Isosurface');
model.result('pg8').feature('iso1').set('expr', 'phiB');
model.result('pg8').feature('iso1').set('levelmethod', 'levels');
model.result('pg8').feature('iso1').set('levels', 0.5);
model.result('pg8').feature('iso1').set('titletype', 'none');
model.result('pg8').feature('iso1').set('coloring', 'uniform');
model.result('pg8').feature('iso1').set('colorlegend', false);
model.result('pg8').feature('iso1').set('color', 'magenta');
model.result('pg8').run;
model.result('pg8').create('iso2', 'Isosurface');
model.result('pg8').feature('iso2').set('expr', 'terpf.phiC');
model.result('pg8').feature('iso2').set('levelmethod', 'levels');
model.result('pg8').feature('iso2').set('levels', 0.5);
model.result('pg8').feature('iso2').set('coloring', 'uniform');
model.result('pg8').feature('iso2').set('titletype', 'none');
model.result('pg8').feature('iso2').set('colorlegend', false);
model.result('pg8').feature('iso2').set('color', 'gray');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').create('slc1', 'Slice');
model.result('pg8').feature('slc1').set('quickxnumber', 1);
model.result('pg8').feature('slc1').set('quickplane', 'zx');
model.result('pg8').feature('slc1').set('quickynumber', 1);
model.result('pg8').feature('slc1').create('def1', 'Deform');
model.result('pg8').feature('slc1').feature('def1').set('revcoordsys', 'cylindrical');
model.result('pg8').run;
model.result('pg8').feature('slc1').feature('def1').set('revcoordsys', 'cartesian');
model.result('pg8').feature('slc1').feature('def1').set('expr', {'0' 'sqrt(0.016^2-r^2)' ''});
model.result('pg8').feature('slc1').feature('def1').setIndex('expr', 0, 2);
model.result('pg8').feature('slc1').feature('def1').set('scaleactive', true);
model.result('pg8').feature('slc1').feature('def1').set('scale', 1);
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 1, 0);
model.result('pg8').set('showlegends', false);
model.result('pg8').set('titletype', 'none');
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 14, 0);
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 26, 0);
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 38, 0);
model.result('pg8').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').selection.all;
model.result.numerical('int1').setIndex('expr', 'tfpf1.VfA/8.447E-5[m^3]', 0);
model.result.numerical('int1').setIndex('unit', 1, 0);
model.result.numerical('int1').setIndex('expr', 'tfpf1.VfB/2.603e-5[m^3]', 1);
model.result.numerical('int1').setIndex('unit', 1, 1);
model.result.numerical('int1').setIndex('descr', '', 1);
model.result.numerical('int1').setIndex('expr', 'tfpf1.VfC/2.1451e-6[m^3]', 2);
model.result.numerical('int1').setIndex('unit', 1, 2);
model.result.numerical('int1').setIndex('descr', '', 2);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').set('data', 'none');
model.result('pg9').create('tblp1', 'Table');
model.result('pg9').feature('tblp1').set('source', 'table');
model.result('pg9').feature('tblp1').set('table', 'tbl1');
model.result('pg9').feature('tblp1').set('linewidth', 'preference');
model.result('pg9').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg9').run;
model.result('pg9').feature('tblp1').set('legend', true);
model.result('pg9').feature('tblp1').set('legendmethod', 'manual');
model.result('pg9').feature('tblp1').setIndex('legends', 'Relative mass of light fluid', 0);
model.result('pg9').feature('tblp1').setIndex('legends', 'Relative mass of heavy fluid', 1);
model.result('pg9').feature('tblp1').setIndex('legends', 'Relative mass of gas', 2);

model.title('Bubble-Induced Entrainment Between Stratified Liquid Layers');

model.description(['This model is a benchmark for three-phase flow commonly used in food processing, pharmaceutical industry, and chemical processing. The results are validated against data reported in the literature.' newline  newline 'A gas bubble rises through two layers of liquid, a lighter liquid resting on top of a heavier one. As the bubble travels from the heavier liquid, it entrains some of the heavier liquid in its wake and moves it into the lighter liquid, creating a tail of heavy liquid.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('three_phase_bubble.mph');

model.modelNode.label('Components');

out = model;
