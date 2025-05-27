function out = model
%
% tesla_microvalve_transient_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics.create('ge', 'GlobalEquations', 'geom1');
model.physics('ge').model('comp1');
model.physics('ge').prop('EquationForm').set('form', 'Automatic');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/ge', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '1[mm]', 'Domain length');
model.param.set('H', '0.35*L', 'Domain height');
model.param.set('L1', 'L/10', 'Inlet height');
model.param.set('Re', '500', 'Reynolds number');
model.param.set('tmax', '1.75*Tperiod', 'Simulation time');
model.param.set('meshsz', '0.02*L', 'Mesh size');
model.param.set('tstep', 'meshsz/L*tmax/3.5', 'Time step');
model.param.set('alpha', '1e4*mu0/L1^2', 'Damping parameter');
model.param.set('mu0', '1e-3[Pa*s]', 'Viscosity');
model.param.set('rho0', '1e3[kg/m^3]', 'Density');
model.param.set('U0', 'Re*mu0/L/rho0', 'Characteristic velocity');
model.param.set('Tperiod', 'L/U0*10', 'Period length');
model.param.set('dp', 'Re*mu0^2/L1^2/rho0', 'Pressure drop amplitude');
model.param.set('beta', '8', 'Projection slope');
model.param.set('q', '0.01', 'Interpolation parameter');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'L' 'H'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'L1');
model.geom('geom1').feature('sq1').set('pos', {'-L1' '0'});
model.geom('geom1').feature('sq1').set('selresult', true);
model.geom('geom1').run('sq1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('sq1');
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displx', 'L+L1');
model.geom('geom1').run('mov1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').label('Symmetry');
model.geom('geom1').feature('boxsel1').set('ymax', 'eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel2', 'boxsel1');
model.geom('geom1').feature('boxsel2').label('Outlet');
model.geom('geom1').feature('boxsel2').set('xmax', '-L1*0.999');
model.geom('geom1').feature('boxsel2').set('ymax', Inf);
model.geom('geom1').feature.duplicate('boxsel3', 'boxsel2');
model.geom('geom1').feature('boxsel3').label('Inlet');
model.geom('geom1').feature('boxsel3').set('xmin', 'L+L1*0.999');
model.geom('geom1').feature('boxsel3').set('xmax', Inf);
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Inlet/Outlet');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'boxsel2' 'boxsel3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('disksel1', 'DiskSelection');
model.geom('geom1').feature('disksel1').label('Pressure Reference Point');
model.geom('geom1').feature('disksel1').set('entitydim', 0);
model.geom('geom1').feature('disksel1').set('r', 'L/1000');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Water');
model.material('mat1').propertyGroup('def').set('density', {'rho0'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu0'});

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').selection.named('geom1_r1_dom');
model.common('dtopo1').set('filterLengthType', 'Custom');
model.common('dtopo1').set('L_min', 'meshsz');
model.common('dtopo1').set('projectionType', 'TanhProjection');
model.common('dtopo1').set('beta', 'beta');
model.common('dtopo1').set('interpolationType', 'Darcy');
model.common('dtopo1').set('q_Darcy', 'q');
model.common('dtopo1').set('discretization', 'constant');
model.common('dtopo1').set('theta_0', '1');
model.common.create('ftopom1', 'MaterialTopologyDomain', 'comp1');
model.common('ftopom1').selection.named('geom1_sq1_dom');

model.probe.create('dom1', 'Domain');
model.probe('dom1').model('comp1');
model.probe('dom1').set('intsurface', true);
model.probe('dom1').set('intvolume', true);
model.probe('dom1').label('Velocity Average');
model.probe('dom1').set('probename', 'uAvg');
model.probe('dom1').selection.named('geom1_r1_dom');
model.probe('dom1').set('type', 'integral');
model.probe('dom1').set('expr', 'u/L/H');

model.physics('spf').create('sym1', 'Symmetry', 1);
model.physics('spf').feature('sym1').selection.named('geom1_boxsel1');
model.physics('spf').create('pfc1', 'PeriodicFlowCondition', 1);
model.physics('spf').feature('pfc1').selection.named('geom1_unisel1');
model.physics('spf').feature('pfc1').set('pdiff', 'dp*cos(2*pi*t/Tperiod)');
model.physics('spf').create('prpc1', 'PressurePointConstraint', 0);
model.physics('spf').feature('prpc1').selection.named('geom1_disksel1');
model.physics('spf').create('vf1', 'VolumeForce', 2);
model.physics('spf').feature('vf1').selection.named('geom1_r1_dom');
model.physics('spf').feature('vf1').set('F', {'-alpha*dtopo1.theta_p*u' '-alpha*dtopo1.theta_p*v' '0'});
model.physics('ge').feature('ge1').setIndex('name', 'obj', 0, 0);
model.physics('ge').feature('ge1').setIndex('equation', 'objt*tmax-(tmax-Tperiod < t)*uAvg/U0', 0, 0);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'meshsz');
model.mesh('mesh1').run;

model.study('std1').label('Optimization');
model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').feature('topo').set('mmamaxiter', 25);
model.study('std1').feature('topo').set('movelimitactive', true);
model.study('std1').feature('topo').set('movelimit', 0.2);
model.study('std1').feature('topo').set('optobj', {'comp1.obj'});
model.study('std1').feature('topo').set('descr', {'State variable obj'});
model.study('std1').feature('topo').set('objectivetype', 'maximization');
model.study('std1').feature('topo').set('objectivescaling', 'manual');
model.study('std1').feature('topo').set('objscaleval', '1.5e-3');
model.study('std1').feature('topo').set('probesel', 'none');
model.study('std1').feature('time').set('tlist', 'range(0,tmax/20,tmax)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'topo');
model.sol('sol1').feature('o1').create('t1', 'TimeAttrib');
model.sol('sol1').feature('o1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('o1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('o1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('o1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('o1').feature('t1').set('atolmethod', {'comp1_dtopo1_theta_c' 'global' 'comp1_dtopo1_theta_f' 'global' 'comp1_p' 'scaled' 'comp1_u' 'global' 'comp1_ODE1' 'global'});
model.sol('sol1').feature('o1').feature('t1').set('atolvaluemethod', {'comp1_dtopo1_theta_c' 'factor' 'comp1_dtopo1_theta_f' 'factor' 'comp1_p' 'factor' 'comp1_u' 'factor' 'comp1_ODE1' 'factor'});
model.sol('sol1').feature('o1').feature('t1').set('atolfactor', {'comp1_dtopo1_theta_c' '0.1' 'comp1_dtopo1_theta_f' '0.1' 'comp1_p' '1' 'comp1_u' '0.1' 'comp1_ODE1' '0.1'});
model.sol('sol1').feature('o1').feature('t1').set('reacf', true);
model.sol('sol1').feature('o1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('o1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('o1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('o1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('o1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('o1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('o1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('o1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('o1').feature('t1').set('control', 'time');
model.sol('sol1').feature('o1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('o1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('o1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('o1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('o1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('o1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('o1').feature('t1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('o1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('o1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('o1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('o1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('o1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runFromTo('st1', 'v1');

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
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
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'obj'});
model.result.numerical('gev1').set('descr', {'State variable obj'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('expr', {'obj'});
model.result('pg3').feature('glob1').set('descr', {'State variable obj'});

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Topology Optimization');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg3');
model.nodeGroup.move('grp1', 1);

model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Output material volume factor');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Threshold');

model.nodeGroup('grp1').add('plotgroup', 'pg4');
model.nodeGroup('grp1').add('plotgroup', 'pg5');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset1');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg4').feature('surf1').set('rangecoloractive', true);
model.result('pg4').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg4').feature('surf1').set('rangecolormin', 0);
model.result('pg4').feature('surf1').set('rangecolormax', 1);
model.result('pg5').set('data', 'filt1');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', '1');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'gray');
model.result('pg5').feature('surf1').set('titletype', 'none');
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').run;

model.sol('sol1').feature('o1').set('stationaryhidesens', 'off');
model.sol('sol1').feature('o1').set('stationaryhideadj', 'off');
model.sol('sol1').feature('o1').set('gcmma', false);
model.sol('sol1').feature('o1').set('gradientmma', 'adjoint');
model.sol('sol1').feature('o1').set('tstepssens', 'fromforward');
model.sol('sol1').feature('o1').feature('t1').set('tstepsbdf', 'manual');
model.sol('sol1').feature('o1').feature('t1').set('timestepbdf', 'tstep');
model.sol('sol1').feature('o1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('o1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ssDef').label('Optimization');
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ssDef').set('segvar', {'comp1_dtopo1_theta_c' 'comp1_dtopo1_theta_f'});
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ss1').label('Fluid Flow');
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_dtopo1_theta_c' 'comp1_p' 'comp1_u'});
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ss2').label('Objective');
model.sol('sol1').feature('o1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_dtopo1_theta_c' 'comp1_ODE1'});
model.sol('sol1').feature('o1').feature('t1').feature('d1').set('linsolver', 'pardiso');

model.study('std1').feature('topo').set('plot', true);
model.study('std1').feature('topo').set('plotgroup', 'pg4');

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result('pg3').run;
model.result('pg3').label('Objective');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').set('data', 'filt1');
model.result('pg1').setIndex('looplevel', 20, 0);
model.result('pg1').run;
model.result.dataset('filt1').set('expr', 'dtopo1.theta_f');
model.result.dataset('filt1').set('descr', 'Filtered material volume factor');
model.result.dataset('filt1').createMeshPart('mcomp1', 'mgeom1', 'mpart1', 'imp1');

model.mesh('mpart1').feature('imp1').importData;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('mesh', 'mpart1');
model.geom('geom2').run('imp1');
model.geom('geom2').run;

model.physics.copy('spf2', 'spf', 'comp2');
model.physics.copy('ge2', 'ge', 'comp2');

model.material.copy('mat2', 'mat1', 'comp2');

model.probe.copy('dom2', 'dom1', 'comp2');
model.probe('dom2').set('probename', 'uAvg');
model.probe('dom2').selection.named('geom2_imp1_mpart1_imp1_geom1_r1_dom');

model.physics('spf2').feature('sym1').selection.named('geom2_imp1_mpart1_imp1_geom1_boxsel1');
model.physics('spf2').feature('pfc1').selection.named('geom2_imp1_mpart1_imp1_geom1_unisel1');
model.physics('spf2').feature('prpc1').selection.named('geom2_imp1_mpart1_imp1_geom1_disksel1');
model.physics('spf2').feature.remove('vf1');
model.physics('ge2').feature('ge1').setIndex('name', 'obj', 0, 0);
model.physics('ge2').feature('ge1').setIndex('equation', 'objt*tmax-(tmax-Tperiod < t)*uAvg/U0', 0, 0);

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('size').set('custom', true);
model.mesh('mesh2').feature('size').set('hmax', 'meshsz/2');
model.mesh('mesh2').feature('size').set('hgrad', Inf);
model.mesh('mesh2').feature('size').set('hcurve', Inf);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').feature.copy('time1', 'std1/time');
model.study('std2').feature('time1').setEntry('activate', 'spf', false);
model.study('std2').feature('time1').setEntry('activate', 'ge', false);
model.study('std2').feature('time1').setEntry('activate', 'comp1:topopt', false);
model.study('std2').feature('time1').set('probesel', 'none');
model.study('std1').feature('time').setEntry('activate', 'spf2', false);
model.study('std1').feature('time').setEntry('activate', 'ge2', false);
model.study('std2').label('Verification');

model.sol.create('sol2');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh2').stat.selection.geom(2);
model.mesh('mesh2').stat.selection.set([1 2 3]);

model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time1');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time1');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,tmax/20,tmax)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'none');
model.sol('sol2').feature('t1').set('probes', {'dom1' 'dom2'});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('rtol', 0.005);
model.sol('sol2').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol2').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('atolmethod', {'comp1_dtopo1_theta_c' 'global' 'comp1_dtopo1_theta_f' 'global' 'comp1_p' 'global' 'comp1_u' 'global' 'comp2_p' 'scaled'  ...
'comp2_u' 'global' 'comp1_ODE1' 'global' 'comp2_ODE1' 'global'});
model.sol('sol2').feature('t1').set('atolvaluemethod', {'comp1_dtopo1_theta_c' 'factor' 'comp1_dtopo1_theta_f' 'factor' 'comp1_p' 'factor' 'comp1_u' 'factor' 'comp2_p' 'factor'  ...
'comp2_u' 'factor' 'comp1_ODE1' 'factor' 'comp2_ODE1' 'factor'});
model.sol('sol2').feature('t1').set('atolfactor', {'comp1_dtopo1_theta_c' '0.1' 'comp1_dtopo1_theta_f' '0.1' 'comp1_p' '0.1' 'comp1_u' '0.1' 'comp2_p' '1'  ...
'comp2_u' '0.1' 'comp1_ODE1' '0.1' 'comp2_ODE1' '0.1'});
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('rhoinf', 0.5);
model.sol('sol2').feature('t1').set('predictor', 'constant');
model.sol('sol2').feature('t1').set('maxorder', 2);
model.sol('sol2').feature('t1').set('stabcntrl', true);
model.sol('sol2').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol2').feature('t1').set('control', 'time1');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('t1').feature('i1').label('AMG, fluid flow variables (spf2)');
model.sol('sol2').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol2').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol2').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol2').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.5);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 8);
model.sol('sol2').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.dataset('dset4').set('geom', 'geom2');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Velocity (spf2)');
model.result('pg6').set('data', 'dset4');
model.result('pg6').setIndex('looplevel', 21, 0);
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').set('data', 'dset4');
model.result('pg6').setIndex('looplevel', 21, 0);
model.result('pg6').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').label('Surface');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').label('Pressure (spf2)');
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevel', 21, 0);
model.result('pg7').set('frametype', 'spatial');
model.result('pg7').set('data', 'dset4');
model.result('pg7').setIndex('looplevel', 21, 0);
model.result('pg7').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg7').feature.create('con1', 'Contour');
model.result('pg7').feature('con1').label('Contour');
model.result('pg7').feature('con1').set('showsolutionparams', 'on');
model.result('pg7').feature('con1').set('expr', 'p');
model.result('pg7').feature('con1').set('number', 40);
model.result('pg7').feature('con1').set('levelrounding', false);
model.result('pg7').feature('con1').set('smooth', 'internal');
model.result('pg7').feature('con1').set('showsolutionparams', 'on');
model.result('pg7').feature('con1').set('data', 'parent');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').set('data', 'dset4');
model.result.numerical('gev2').set('expr', {'obj'});
model.result.numerical('gev2').set('descr', {'State variable obj'});
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset4');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('expr', {'obj'});
model.result('pg8').feature('glob1').set('descr', {'State variable obj'});

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').label('Topology Optimization 1');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg8');
model.nodeGroup.move('grp2', 2);

model.result.create('pg9', 'PlotGroup2D');
model.result('pg9').label('Output material volume factor 1');
model.result.create('pg10', 'PlotGroup2D');
model.result('pg10').label('Threshold 1');

model.nodeGroup('grp2').add('plotgroup', 'pg9');
model.nodeGroup('grp2').add('plotgroup', 'pg10');

model.result.dataset.create('filt2', 'Filter');
model.result.dataset('filt2').label('Filter 1');
model.result.dataset('filt2').set('data', 'dset3');
model.result.dataset('filt2').set('expr', 'dtopo1.theta');
model.result.dataset('filt2').set('lowerexpr', '0.5');
model.result.dataset('filt2').set('smooth', 'none');
model.result.dataset('filt2').set('useder', false);
model.result('pg9').set('data', 'dset3');
model.result('pg9').create('surf1', 'Surface');
model.result('pg9').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg9').feature('surf1').set('rangecoloractive', true);
model.result('pg9').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg9').feature('surf1').set('rangecolormin', 0);
model.result('pg9').feature('surf1').set('rangecolormax', 1);
model.result('pg10').set('data', 'filt2');
model.result('pg10').create('surf1', 'Surface');
model.result('pg10').feature('surf1').set('expr', '1');
model.result('pg10').feature('surf1').set('coloring', 'uniform');
model.result('pg10').feature('surf1').set('color', 'gray');
model.result('pg10').feature('surf1').set('titletype', 'none');
model.result('pg6').run;
model.result('pg1').run;

model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup.remove('grp2');

model.result('pg8').run;
model.result('pg8').label('Objective (Verification)');
model.result('pg6').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').add('plotgroup', 'pg7');
model.nodeGroup('grp2').add('plotgroup', 'pg8');
model.nodeGroup('grp2').label('Verification');

model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature.duplicate('gev2', 'gev1');
model.result.evaluationGroup('eg1').feature('gev2').set('data', 'dset4');
model.result.evaluationGroup('eg1').feature('gev2').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').run;
model.result('pg6').run;
model.result('pg6').stepPrevious(0);
model.result('pg6').run;

model.title('Optimization of a Tesla Microvalve with Transient Flow');

model.description('This example performs a topological optimization for a Tesla microvalve for an oscillating pressure drop. A Tesla microvalve inhibits backward flow using friction forces rather than moving parts, and therefore the objective is to maximize the average flow rate. The design can be optimized by distributing material within the modeling domain.');

model.mesh('mesh1').clearMesh;
model.mesh('mpart1').clearMesh;
model.mesh('mesh2').clearMesh;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('tesla_microvalve_transient_optimization.mph');

model.modelNode.label('Components');

out = model;
