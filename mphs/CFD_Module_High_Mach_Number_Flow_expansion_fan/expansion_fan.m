function out = model
%
% expansion_fan.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/High_Mach_Number_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('hmnf', 'HighMachNumberFlow', 'geom1');
model.physics('hmnf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/hmnf', true);

model.param.set('M1', '2.5');
model.param.descr('M1', 'Mach number, inlet');
model.param.set('pin_tot', '12[psi]');
model.param.descr('pin_tot', 'Total pressure, inlet');
model.param.set('Tin_tot', '550[R]');
model.param.descr('Tin_tot', 'Total temperature, inlet');
model.param.set('Rs', '287[J/kg/K]');
model.param.descr('Rs', 'Specific gas constant');
model.param.set('gamma', '1.4[1]');
model.param.descr('gamma', 'Ratio of specific heats');
model.param.set('L_in', '3[m]');
model.param.descr('L_in', 'Length, inlet');
model.param.set('L_wave', '4.5[m]');
model.param.descr('L_wave', 'Length after the corner');
model.param.set('ht', 'L_in');
model.param.descr('ht', 'Channel height');
model.param.set('R_fillet', '0.1[m]');
model.param.descr('R_fillet', 'Radius, rounded corner');
model.param.set('theta', '15[deg]');
model.param.descr('theta', 'Flow-deflection angle');
model.param.set('u_in', 'M1*sqrt(gamma*Rs*Tin_tot/(1+0.5*M1^2*(-1+gamma))+eps)');
model.param.descr('u_in', 'Velocity, inlet');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0, L_in, L_in, L_in+L_wave, L_in+L_wave, L_in+L_wave, L_in+L_wave, 0, 0, 0');
model.geom('geom1').feature('pol1').set('y', '0, 0, 0, -L_wave*tan(theta), -L_wave*tan(theta), ht, ht, ht, ht, 0');
model.geom('geom1').run('pol1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('pol1', 3);
model.geom('geom1').feature('fil1').set('radius', 'R_fillet');
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('v1', 'sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)*(M1^2-1)/(gamma+1)))-atan(sqrt(M1^2-1))');
model.variable('var1').descr('v1', 'Prandtl-Meyer function, inlet');
model.variable('var1').set('vi2', 'sqrt((gamma+1)/(gamma-1))*atan(sqrt((gamma-1)*(M2^2-1)/(gamma+1)))-atan(sqrt(M2^2-1))');
model.variable('var1').descr('vi2', 'Guess for Prandtl-Meyer function after expansion fan');
model.variable('var1').set('v2', 'theta+v1');
model.variable('var1').descr('v2', 'Residual for global equation');
model.variable('var1').set('Tin_stat', 'Tin_tot/(1+0.5*M1^2*(-1+gamma))');
model.variable('var1').descr('Tin_stat', 'Static temperature, inlet');
model.variable('var1').set('pin_stat', 'pin_tot/(1+0.5*M1^2*(-1+gamma))^(gamma/(-1+gamma))');
model.variable('var1').descr('pin_stat', 'Static pressure, inlet');

model.physics('hmnf').feature('fluid1').set('k_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('k', {'1e-8' '0' '0' '0' '1e-8' '0' '0' '0' '1e-8'});
model.physics('hmnf').feature('fluid1').set('Rs_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('Rs', 'Rs');
model.physics('hmnf').feature('fluid1').set('CpOrGammaOption', 'gamma');
model.physics('hmnf').feature('fluid1').set('gamma_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('gamma', 'gamma');
model.physics('hmnf').feature('fluid1').set('mu_mat', 'userdef');
model.physics('hmnf').feature('fluid1').set('mu', '1e-8');
model.physics('hmnf').feature('wallbc1').set('BoundaryCondition', 'Slip');
model.physics('hmnf').feature('init1').set('u_init', {'u_in' '0' '0'});
model.physics('hmnf').feature('init1').set('p_init', 'pin_stat');
model.physics('hmnf').feature('init1').set('Tinit', 'Tin_stat');
model.physics('hmnf').create('hminl1', 'HighMachNumberFlowInlet', 1);
model.physics('hmnf').feature('hminl1').selection.set([1]);
model.physics('hmnf').feature('hminl1').set('FlowCondition', 'Supersonic');
model.physics('hmnf').feature('hminl1').set('InputState', 'TotalConditions');
model.physics('hmnf').feature('hminl1').set('p0tot', 'pin_tot');
model.physics('hmnf').feature('hminl1').set('T0tot', 'Tin_tot');
model.physics('hmnf').feature('hminl1').set('Ma0', 'M1');
model.physics('hmnf').create('hmout1', 'HighMachNumberFlowOutlet', 1);
model.physics('hmnf').feature('hmout1').selection.set([5]);
model.physics('hmnf').feature('hmout1').set('FlowCondition', 'Supersonic');
model.physics('hmnf').create('ge1', 'GlobalEquations', -1);
model.physics('hmnf').feature('ge1').setIndex('name', 'M2', 0, 0);
model.physics('hmnf').feature('ge1').setIndex('equation', 'v2-vi2', 0, 0);
model.physics('hmnf').feature('ge1').setIndex('initialValueU', 'M1', 0, 0);
model.physics('hmnf').feature('ge1').setIndex('description', 'Mach flow after the expansion fan, analytical solution', 0, 0);

model.mesh('mesh1').run;

model.study('std1').feature('stat').set('errestandadap', 'adaption');
model.study('std1').feature('stat').set('meshadaptmethod', 'modify');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 1);
model.sol('sol1').feature('s1').feature('fc1').set('mincfl', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cflaa', true);
model.sol('sol1').feature('s1').feature('fc1').set('cflaacfl', 9000);
model.sol('sol1').feature('s1').feature('fc1').set('cflaafact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, fluid flow variables (hmnf)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, fluid flow variables (hmnf)');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_ODE1'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_ODE1'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('damp', 0.8);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'cflcmp');
model.sol('sol1').feature('s1').feature('fc1').set('initcfl', 1);
model.sol('sol1').feature('s1').feature('fc1').set('mincfl', 10000);
model.sol('sol1').feature('s1').feature('fc1').set('kppid', 0.65);
model.sol('sol1').feature('s1').feature('fc1').set('kdpid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('kipid', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cfltol', 0.05);
model.sol('sol1').feature('s1').feature('fc1').set('cflaa', true);
model.sol('sol1').feature('s1').feature('fc1').set('cflaacfl', 9000);
model.sol('sol1').feature('s1').feature('fc1').set('cflaafact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 150);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-5');
model.sol('sol1').runAll;

model.result.dataset('dset2').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (hmnf)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (hmnf)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 3, 0);
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
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Temperature (hmnf)');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'T');
model.result('pg3').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Mach Number (hmnf)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').set('defaultPlotID', 'MultiphysicsHighMachNumberFlow/icom1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'hmnf.Ma');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg1').run;

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').selection.set([1]);
model.result('pg4').feature('str1').set('selnumber', 10);
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowdistr', 'equaltime');
model.result('pg4').feature('str1').set('arrowscaleactive', true);
model.result('pg4').feature('str1').set('arrowscale', '1e-3');
model.result('pg4').feature('str1').set('color', 'gray');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('data', 'dset2');
model.result.dataset('cpt1').set('pointx', 'L_in+L_wave');
model.result.dataset('cpt1').set('pointy', '-L_wave*tan(theta)/2');
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical('pev1').label('Mach number');
model.result.numerical('pev1').set('data', 'cpt1');
model.result.numerical('pev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev1').setIndex('expr', 'hmnf.Ma', 0);
model.result.numerical('pev1').setIndex('unit', 1, 0);
model.result.numerical('pev1').setIndex('descr', 'Mach number', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Mach number');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical('pev2').label('Total pressure');
model.result.numerical('pev2').set('data', 'cpt1');
model.result.numerical('pev2').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev2').setIndex('expr', 'p*(1+0.5*hmnf.Ma^2*(-1+gamma))^(gamma/(-1+gamma))', 0);
model.result.numerical('pev2').setIndex('unit', 'Pa', 0);
model.result.numerical('pev2').setIndex('descr', '', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Total pressure');
model.result.numerical('pev2').set('table', 'tbl2');
model.result.numerical('pev2').setResult;
model.result.numerical.create('pev3', 'EvalPoint');
model.result.numerical('pev3').label('Total Temperature');
model.result.numerical('pev3').set('data', 'cpt1');
model.result.numerical('pev3').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev3').setIndex('expr', 'T*(1+0.5*hmnf.Ma^2*(-1+gamma))', 0);
model.result.numerical('pev3').setIndex('unit', 'K', 0);
model.result.numerical('pev3').setIndex('descr', '', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Total Temperature');
model.result.numerical('pev3').set('table', 'tbl3');
model.result.numerical('pev3').setResult;
model.result.numerical.create('pev4', 'EvalPoint');
model.result.numerical('pev4').label('Total Density');
model.result.numerical('pev4').set('data', 'cpt1');
model.result.numerical('pev4').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev4').setIndex('expr', 'hmnf.rho*(1+0.5*hmnf.Ma^2*(-1+gamma))^(1/(-1+gamma))', 0);
model.result.numerical('pev4').setIndex('unit', 'kg/m^3', 0);
model.result.numerical('pev4').setIndex('descr', '', 0);
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Total Density');
model.result.numerical('pev4').set('table', 'tbl4');
model.result.numerical('pev4').setResult;
model.result.numerical.create('pev5', 'EvalPoint');
model.result.numerical('pev5').label('Mach number, analytical solution');
model.result.numerical('pev5').set('data', 'cpt1');
model.result.numerical('pev5').setIndex('looplevelinput', 'last', 0);
model.result.numerical('pev5').setIndex('expr', 'M2', 0);
model.result.numerical('pev5').setIndex('unit', 1, 0);
model.result.numerical('pev5').setIndex('descr', '', 0);
model.result.table.create('tbl5', 'Table');
model.result.table('tbl5').comments('Mach number, analytical solution');
model.result.numerical('pev5').set('table', 'tbl5');
model.result.numerical('pev5').setResult;
model.result('pg4').run;

model.title('Expansion Fan');

model.description(['An important and interesting phenomenon with supersonic flows are expansion fans, which take place when the flow encounters a convex or expansion corner. The direction of the flow changes smoothly across the fan, while the Mach number increases.' newline  newline 'This 2D example models an expansion fan where the flow is inviscid, and the results are compared with inviscid compressible flow theory. An adaptive mesh is used to resolve the expansion region more finely than the rest of the modeling domain.' newline  newline 'Results correlate well with those conducted using inviscid compressible flow theory.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('expansion_fan.mph');

model.modelNode.label('Components');

out = model;
