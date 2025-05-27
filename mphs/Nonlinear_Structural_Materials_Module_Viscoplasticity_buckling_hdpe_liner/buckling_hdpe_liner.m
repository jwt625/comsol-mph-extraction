function out = model
%
% buckling_hdpe_liner.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Viscoplasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);

model.param.label('Material Properties');
model.param.set('mu', '9.25[MPa]');
model.param.descr('mu', 'Shear modulus');
model.param.set('beta1', '20');
model.param.descr('beta1', 'Energy factor, network 1');
model.param.set('beta2_i', '23.7');
model.param.descr('beta2_i', 'Initial energy factor, network 2');
model.param.set('beta2_f', '11.2');
model.param.descr('beta2_f', 'Final energy factor, network 2');
model.param.set('alpha', '30');
model.param.descr('alpha', 'Energy factor evolution coefficient');
model.param.set('thetar', '-94[K]');
model.param.descr('thetar', 'Stiffness temperature response');
model.param.set('m', '117.2');
model.param.descr('m', 'Temperature exponent');
model.param.set('theta0', '273.15[K]');
model.param.descr('theta0', 'Reference temperature');
model.param.set('T', '293.15[K]');
model.param.descr('T', 'Temperature');
model.param.create('par2');
model.param('par2').label('Geometrical Parameters');
model.param('par2').set('L', '1[m]');
model.param('par2').descr('L', 'Length of pipe');
model.param('par2').set('outer_r', '114[mm]/2');
model.param('par2').descr('outer_r', 'Outer radius of liner');
model.param('par2').set('th_liner', '6.2[mm]');
model.param('par2').descr('th_liner', 'Thickness of liner');
model.param('par2').set('A0', 'pi*(outer_r-th_liner)^2');
model.param('par2').descr('A0', 'Nominal inner area');
model.param('par2').set('th_pipe', '5[mm]');
model.param('par2').descr('th_pipe', 'Thickness of pipe');
model.param.create('par3');
model.param('par3').label('Gas Properties');
model.param('par3').set('M', '16.04[g/mol]');
model.param('par3').descr('M', 'Molar mass');
model.param('par3').set('Rs', 'R_const/M');
model.param('par3').descr('Rs', 'Gas constant per unit mass');
model.param('par3').set('mdot', '750[cm^3/min]*0.657[kg/m^3]');
model.param('par3').descr('mdot', 'Mass rate');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'outer_r');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', 180);
model.geom('geom1').feature('c1').setIndex('layer', 'th_liner', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('e1', 'Ellipse');
model.geom('geom1').feature('e1').set('semiaxes', {'outer_r' 'outer_r*0.996'});
model.geom('geom1').feature('e1').set('angle', 180);
model.geom('geom1').feature('e1').setIndex('layer', 'th_liner', 0);
model.geom('geom1').run('e1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('c1', [1 2]);
model.geom('geom1').feature('del1').selection('input').set('e1', [2 3]);
model.geom('geom1').run('del1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'outer_r+th_pipe');
model.geom('geom1').feature('c2').set('angle', 180);
model.geom('geom1').feature('c2').set('rot', 90);
model.geom('geom1').feature('c2').setIndex('layer', 'th_pipe', 0);
model.geom('geom1').run('c2');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init(2);
model.geom('geom1').feature('del2').selection('input').set('c2', 2);
model.geom('geom1').run('del2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'del1'});
model.geom('geom1').run('uni1');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('createpairs', false);
model.geom('geom1').run('fin');

model.pair.create('p1', 'Contact', 'geom1');
model.pair('p1').source.set([6 7]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').label('Pipe');
model.selection('sel1').set([6 7]);

model.pair('p1').source.named('sel1');
model.pair('p1').destination.set([11 12]);

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(1);
model.selection('sel2').label('Liner Outer Surface');
model.selection('sel2').set([11 12]);

model.pair('p1').destination.named('sel2');

model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(1);
model.selection('sel3').set([13 14]);
model.selection('sel3').label('Liner Inner Surface');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.named('sel3');
model.cpl('intop1').label('Inner Area Integrator');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.named('sel2');
model.cpl('intop2').label('Gap Area Integrator');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('A', '2*intop1(-x*solid.nx)');
model.variable('var1').descr('A', 'Actual inner area');
model.variable('var1').set('Ag', 'pi*outer_r^2-2*intop2(x*solid.nx)');
model.variable('var1').descr('Ag', 'Actual gap area');
model.variable('var1').set('V', 'L*Ag');
model.variable('var1').descr('V', 'Actual gap volume');

model.physics('solid').selection.set([3 4]);

model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').label('Liner');
model.selection('sel4').set([3 4]);

model.physics('solid').selection.named('sel4');
model.physics('solid').prop('d').set('d', 'L');
model.physics('solid').feature('dcnt1').set('penaltyCtrlPenalty', 'ManualTuning');
model.physics('solid').feature('dcnt1').set('fp_penalty', 8);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl1').label('Inner Pressure');
model.physics('solid').feature('bndl1').selection.named('sel3');
model.physics('solid').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl1').set('FollowerPressure', '1[atm]');
model.physics('solid').create('bndl2', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl2').label('Outer Pressure');
model.physics('solid').feature('bndl2').selection.named('sel2');
model.physics('solid').feature('bndl2').set('LoadType', 'FollowerPressure');
model.physics('solid').feature('bndl2').set('FollowerPressure', 'Rs*mdot*t*T/V');
model.physics('solid').feature('bndl2').set('pairContrib', 'allRegions');
model.physics('solid').create('sym1', 'SymmetrySolid', 1);
model.physics('solid').feature('sym1').selection.set([9 10]);
model.physics('solid').create('hmm1', 'HyperelasticModel', 2);
model.physics('solid').feature('hmm1').selection.named('sel4');
model.physics('solid').feature('hmm1').set('MaterialModel', 'ArrudaBoyce');
model.physics('solid').feature('hmm1').set('Compressibility_ArrudaBoyce', 'CompressibleUncoupled');
model.physics('solid').feature('hmm1').create('pvp1', 'PolymerViscoplasticity', 2);
model.physics('solid').feature('hmm1').feature('pvp1').set('ViscoplasticityModel', 'BergstromBischoff');
model.physics('solid').feature('hmm1').feature('pvp1').set('betav1', 'beta1');
model.physics('solid').feature('hmm1').feature('pvp1').set('betav2_i', 'beta2_i');
model.physics('solid').feature('hmm1').feature('pvp1').set('betav2_f', 'beta2_f');
model.physics('solid').feature('hmm1').feature('pvp1').set('alpha', 'alpha');
model.physics('solid').feature('hmm1').feature('pvp1').set('thermalEffects', 'powerLaw');
model.physics('solid').feature('hmm1').feature('pvp1').set('m', 'm');
model.physics('solid').feature('hmm1').feature('pvp1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('hmm1').feature('pvp1').set('minput_temperature', 'T');
model.physics('solid').feature('hmm1').feature('pvp1').set('T0', 'theta0');
model.physics('solid').feature('hmm1').feature('pvp1').set('timeMethod', 'ode');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.named('sel4');
model.material('mat1').propertyGroup.create('KG', 'Bulk_modulus_and_shear_modulus');
model.material('mat1').propertyGroup('KG').set('K', {'2[GPa]'});
model.material('mat1').propertyGroup.create('ArrudaBoyce', 'Arruda-Boyce');
model.material('mat1').propertyGroup('ArrudaBoyce').set('Nseg', {'4.5'});
model.material('mat1').propertyGroup('ArrudaBoyce').set('mu0', {'mu*(1+(T-theta0)/thetar)'});
model.material('mat1').propertyGroup('def').set('density', {'950[kg/m^3]'});
model.material('mat1').propertyGroup.create('BergstromBischoff', 'Bergstrom-Bischoff_viscoplasticity');
model.material('mat1').propertyGroup('BergstromBischoff').set('A_BeBi', {'sqrt(2/3)[1/s]'});
model.material('mat1').propertyGroup('BergstromBischoff').set('sigRes1_BeBi', {'7.1[MPa]'});
model.material('mat1').propertyGroup('BergstromBischoff').set('n1_BeBi', {'13'});
model.material('mat1').propertyGroup('BergstromBischoff').set('a1_BeBi', {'0.183'});
model.material('mat1').propertyGroup('BergstromBischoff').set('sigRes2_BeBi', {'32.2[MPa]'});
model.material('mat1').propertyGroup('BergstromBischoff').set('n2_BeBi', {'22.4'});
model.material('mat1').propertyGroup('BergstromBischoff').set('a2_BeBi', {'0.183'});
model.material('mat1').label('HDPE');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([3 4]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([10]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.named('sel3');
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 25);
model.mesh('mesh1').run;
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map2').selection.set([1 2]);
model.mesh('mesh1').feature('map2').create('size1', 'Size');
model.mesh('mesh1').feature('map2').feature('size1').set('hauto', 3);
model.mesh('mesh1').run('map2');

model.study('std1').create('stat', 'Stationary');
model.study('std1').feature.move('stat', 0);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/bndl2'});

model.physics('solid').feature('hmm1').feature('pvp1').set('StaticResponse', 'Instantaneous');

model.study('std1').feature('time').set('tlist', 'range(0,5,20[min])');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.13863621460498698');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'ddog');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_u').set('scaleval', '1e-2*0.13863621460498698');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5,20[min])');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.5);
model.sol('sol1').feature('t1').feature('fc1').set('useminsteprecovery', 'on');
model.sol('sol1').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v2').feature('comp1_solid_hmm1_pvp1_evp1').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_solid_hmm1_pvp1_evp2').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_solid_hmm1_pvp1_evpe1').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_solid_hmm1_pvp1_evpe2').set('scalemethod', 'manual');
model.sol('sol1').feature('t1').set('timemethod', 'bdf');
model.sol('sol1').feature('t1').feature('fc1').set('minstep', 0.25);
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 20);
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '2*comp1.intop1(-x*comp1.solid.nx)/A0<0.6', 0);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'A0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^2', 0);
model.study('std1').feature('param').setIndex('pname', 'A0', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm^2', 0);
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '278.15 298.15 323.15', 0);

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'T'});
model.batch('p1').set('plistarr', {'278.15 298.15 323.15'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol3');
model.sol('sol3').study('std1');
model.sol('sol3').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol3');
model.batch('p1').getInitialValue;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset3');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', '1');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result('pg1').run;
model.result('pg1').label('Displacements Magnitude');
model.result('pg1').set('data', 'mir1');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Displacements [mm]');
model.result('pg1').set('paramindicator', 'Time=eval(t) s, T=eval(T) K');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('surf1').label('Liner');
model.result('pg1').feature('surf1').set('expr', 'solid.disp');
model.result('pg1').feature('surf1').set('unit', 'mm');
model.result('pg1').run;
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').label('Pipe');
model.result('pg1').feature('line1').set('expr', '1');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'fromtheme');
model.result('pg1').feature('line1').create('sel1', 'Selection');
model.result('pg1').feature('line1').feature('sel1').selection.named('sel1');

model.study('std1').feature('time').set('plot', true);
model.study('std1').feature('time').set('plotfreq', 'tsteps');
model.study('std1').setGenPlots(false);

model.batch('p1').run('compute');

model.result('pg1').run;
model.result.dataset('mir1').set('data', 'dset3');
model.result('pg1').run;
model.result('pg1').set('looplevel', [108 1]);
model.result('pg1').stepLast(0);
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').set('data', 'dset3');
model.result('pg2').label('Gas Pressure');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Gas Pressure');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Pressure (atm)');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'Rs*mdot*t*T/V', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'atm', 0);
model.result('pg2').feature('glob1').set('linestyle', 'dashed');
model.result('pg2').feature('glob1').set('linewidth', 2);
model.result('pg2').feature('glob1').set('linemarker', 'asterisk');
model.result('pg2').run;
model.result('pg2').run;
model.result.dataset.create('extr1', 'Extrude2D');
model.result.dataset('extr1').set('data', 'mir1');
model.result.dataset('extr1').set('zmax', '20[cm]');
model.result.dataset('extr1').set('planemap', 'yz');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('3D Pipe and Liner');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('paramindicator', 'Time=eval(t) s, T=eval(T) K');
model.result('pg3').set('edges', false);
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', '1');
model.result('pg3').feature('vol1').set('coloring', 'uniform');
model.result('pg3').run;
model.result('pg3').feature('vol1').create('mtrl1', 'MaterialAppearance');
model.result('pg3').run;
model.result('pg3').feature('vol1').feature('mtrl1').set('appearance', 'custom');
model.result('pg3').feature('vol1').feature('mtrl1').set('family', 'rubber');
model.result('pg3').feature('vol1').feature('mtrl1').set('color', 'gray');
model.result('pg3').run;
model.result('pg3').feature('vol1').label('Liner');
model.result('pg3').feature('vol1').create('def1', 'Deform');
model.result('pg3').run;
model.result('pg3').feature('vol1').feature('def1').set('scaleactive', true);
model.result('pg3').feature('vol1').feature('def1').set('scale', 1);
model.result('pg3').feature('vol1').feature('def1').set('expr', {'0' 'u' 'v'});
model.result.dataset.duplicate('mir2', 'mir1');
model.result.dataset('mir2').selection.geom('geom1', 2);
model.result.dataset('mir2').selection.geom('geom1', 2);
model.result.dataset('mir2').selection.set([1 2]);
model.result.dataset.duplicate('extr2', 'extr1');
model.result.dataset('extr2').set('data', 'mir2');
model.result.dataset('extr2').set('zmin', '5');
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Pipe');
model.result('pg3').feature('surf1').set('data', 'extr2');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg3').feature('surf1').feature('mtrl1').set('family', 'steelscratched');

model.view('view3').set('showgrid', false);
model.view('view3').set('ssao', true);

model.result('pg3').run;
model.result('pg3').run;

model.title('Buckling of HDPE Liners');

model.description(['In this example, the Bergstrom' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Bischoff material model is used to model the temperature and strain dependent behavior of High Density Polyethylene (HDPE) used, for example, to make liners for damaged pipes in oil and gas applications, or to make type IV hydrogen storage vessels for fuel cells. In both cases, the liner is prone to collapse due to penetration of gas between the liner and the hosting structure. This model predicts the collapse pressure for different working temperatures.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('buckling_hdpe_liner.mph');

model.modelNode.label('Components');

out = model;
