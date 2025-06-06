function out = model
%
% mesfet.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Semiconductor_Module/Transistors');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('semi', 'Semiconductor', 'geom1');
model.physics('semi').model('comp1');

model.param.set('L', '1[um]');
model.param.descr('L', 'Gate length');
model.param.set('Wd', '4[um]');
model.param.descr('Wd', 'Device width');
model.param.set('Hd', '0.5[um]');
model.param.descr('Hd', 'Device height');
model.param.set('Ws', '1[um]');
model.param.descr('Ws', 'Source width');
model.param.set('Wdd', '1[um]');
model.param.descr('Wdd', 'Drain width');
model.param.set('Vg', '0[V]');
model.param.descr('Vg', 'Gate voltage');
model.param.set('Vd', '0[V]');
model.param.descr('Vd', 'Drain voltage');
model.param.set('Vs', '0[V]');
model.param.descr('Vs', 'Source voltage');
model.param.set('Nd', '1e16[1/cm^3]');
model.param.descr('Nd', 'Doping');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Wd' 'Hd'});
model.geom('geom1').feature('r1').set('pos', {'-Wd/2' '0'});
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-Wd/2+Ws/2 -L/2 L/2 Wd/2-Ws/2', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'Hd Hd Hd Hd', 1);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('SemicondMaterial', 'Semiconductor material');
model.material('mat1').propertyGroup.create('JainRoulstonModel', ['Jain' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Roulston model']);
model.material('mat1').label('GaAs - Gallium Arsenide');
model.material('mat1').propertyGroup('def').set('heatcapacity', '330[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('density', '5500[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'46[W/(m*K)]' '0' '0' '0' '46[W/(m*K)]' '0' '0' '0' '46[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'12.9' '0' '0' '0' '12.9' '0' '0' '0' '12.9'});
model.material('mat1').propertyGroup('SemicondMaterial').set('Eg0', '1.424[V]');
model.material('mat1').propertyGroup('SemicondMaterial').set('chi0', '4.07[V]');
model.material('mat1').propertyGroup('SemicondMaterial').set('Nv', '(T/1[K])^(3/2)*1.83e15[1/cm^3]');
model.material('mat1').propertyGroup('SemicondMaterial').set('Nc', '(8.63e13*(T/1[K])^(3/2)*(1-1.93e-4*(T/1[K])-4.19e-8*(T/1[K])^2+21*exp(-0.29[V]*e_const/(k_B_const*T))+44*exp(-0.48[V]*e_const/(k_B_const*T))))[1/cm^3]');
model.material('mat1').propertyGroup('SemicondMaterial').set('mun', '8500[cm^2/(V*s)]');
model.material('mat1').propertyGroup('SemicondMaterial').set('mup', '400[cm^2/(V*s)]');
model.material('mat1').propertyGroup('SemicondMaterial').addInput('temperature');
model.material('mat1').propertyGroup('JainRoulstonModel').set('An_jr', '16.5e-9[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Bn_jr', '2.39e-7[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Cn_jr', '91.4e-12[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Ap_jr', '9.83e-9[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Bp_jr', '3.9e-7[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Cp_jr', '3.9e-12[V]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('Nref_jr', '1[1/cm^3]');
model.material('mat1').propertyGroup('JainRoulstonModel').set('alpha_jr', '0.5');

model.physics('semi').create('mc1', 'MetalContact', 1);
model.physics('semi').feature('mc1').set('ContactType', 'Schottky');
model.physics('semi').feature('mc1').selection.set([5]);
model.physics('semi').feature('mc1').set('V0', '-Vg');
model.physics('semi').create('mc2', 'MetalContact', 1);
model.physics('semi').feature('mc2').selection.set([3]);
model.physics('semi').feature('mc2').set('V0', 'Vs');
model.physics('semi').create('mc3', 'MetalContact', 1);
model.physics('semi').feature('mc3').selection.set([7]);
model.physics('semi').feature('mc3').set('V0', 'Vd');
model.physics('semi').create('adm1', 'AnalyticDopingModel', 2);
model.physics('semi').feature('adm1').selection.set([1]);
model.physics('semi').feature('adm1').set('impurityType', 'donor');
model.physics('semi').feature('adm1').set('NDc', 'Nd');
model.physics('semi').create('tar1', 'TrapAssistedRecombination', 2);
model.physics('semi').feature('tar1').selection.set([1]);
model.physics('semi').feature('tar1').set('taun_mat', 'userdef');
model.physics('semi').feature('tar1').set('taup_mat', 'userdef');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size2').set('hauto', 3);
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/semi', true);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'L', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'Vg', 0);
model.study('std1').feature('stat').setIndex('pname', 'L', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', 'm', 1);
model.study('std1').feature('stat').setIndex('pname', 'L', 1);
model.study('std1').feature('stat').setIndex('plistarr', '', 1);
model.study('std1').feature('stat').setIndex('punit', 'm', 1);
model.study('std1').feature('stat').setIndex('plistarr', '0 1 2', 0);
model.study('std1').feature('stat').setIndex('pname', 'Vd', 1);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,1,10)', 1);
model.study('std1').feature('stat').set('sweeptype', 'filled');
model.study('std1').feature('stat').set('preusesol', 'auto');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-6);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', false);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').feature('aDef').set('assemtol', 0);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol1').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.001);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('d1').set('mumpsalloc', 1.2);
model.sol('sol1').feature('s1').feature('d1').set('ooc', 'off');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'off');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol1').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.001);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electron Concentration (semi)');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 11, 0);
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('expr', 'semi.N');
model.result('pg1').feature('surf1').set('unit', '1/cm^3');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Hole Concentration (semi)');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 11, 0);
model.result('pg2').setIndex('looplevel', 3, 1);
model.result('pg2').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'semi.P');
model.result('pg2').feature('surf1').set('unit', '1/cm^3');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg2').feature('surf1').set('resolution', 'norefine');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Potential (semi)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 11, 0);
model.result('pg3').setIndex('looplevel', 3, 1);
model.result('pg3').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg3');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('expr', 'V');
model.result('pg3').feature('surf1').set('resolution', 'norefine');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('surf2', 'Surface');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf2').set('expr', 'semi.Nnetdop');
model.result('pg4').feature('surf2').set('unit', '1/cm^3');
model.result('pg4').feature('surf2').set('coloring', 'gradient');
model.result('pg4').feature('surf2').set('colorscalemode', 'logarithmic');
model.result('pg4').feature('surf2').set('topcolor', 'red');
model.result('pg4').feature('surf2').set('bottomcolor', 'custom');
model.result('pg4').feature('surf2').set('custombottomcolor', [1 0.8 0.8]);
model.result('pg4').feature('surf2').set('smooth', 'internal');
model.result('pg4').feature('surf2').set('showsolutionparams', 'on');
model.result('pg4').feature('surf2').set('data', 'parent');
model.result('pg4').feature('surf2').set('titletype', 'none');
model.result('pg4').feature('surf2').feature.create('filt1', 'Filter');
model.result('pg4').feature('surf2').feature('filt1').set('expr', 'semi.Na-semi.Nd > 1[1/cm^3]');
model.result('pg4').feature('surf2').feature('filt1').set('useder', true);
model.result('pg4').feature('surf1').set('expr', 'semi.Nnetdop');
model.result('pg4').feature('surf1').set('unit', '1/cm^3');
model.result('pg4').feature('surf1').set('coloring', 'gradient');
model.result('pg4').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg4').feature('surf1').set('topcolor', 'blue');
model.result('pg4').feature('surf1').set('bottomcolor', 'custom');
model.result('pg4').feature('surf1').set('custombottomcolor', [0.8 0.8 1]);
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').set('titletype', 'none');
model.result('pg4').feature('surf1').feature.create('filt1', 'Filter');
model.result('pg4').feature('surf1').feature('filt1').set('expr', 'semi.Nd-semi.Na > 1[1/cm^3]');
model.result('pg4').feature('surf1').feature('filt1').set('useder', true);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Net Dopant Concentration \vert N<sub>d</sub> - N<sub>a</sub>\vert: P-type (Red), N-type (Blue)');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('legendpos', 'alternating');
model.result('pg4').feature('surf2').label('P-type');
model.result('pg4').feature('surf1').label('N-type');
model.result('pg4').label('Net Dopant Concentration (semi)');
model.result('pg1').run;
model.result('pg4').run;
model.result.remove('pg4');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'semi.I0_3'});
model.result('pg4').feature('glob1').set('descr', {'Terminal current'});
model.result('pg4').feature('glob1').set('unit', {'A'});
model.result('pg4').feature('glob1').setIndex('descr', 'Electrons and holes', 0);
model.result('pg4').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/semi', true);
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'L', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'L', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'm', 0);
model.study('std2').feature('stat').setIndex('pname', 'Vg', 0);
model.study('std2').feature('stat').setIndex('pname', 'L', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'm', 1);
model.study('std2').feature('stat').setIndex('pname', 'L', 1);
model.study('std2').feature('stat').setIndex('plistarr', '', 1);
model.study('std2').feature('stat').setIndex('punit', 'm', 1);
model.study('std2').feature('stat').setIndex('plistarr', '0 1 2', 0);
model.study('std2').feature('stat').setIndex('pname', 'Vd', 1);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,1,10)', 1);
model.study('std2').feature('stat').set('sweeptype', 'filled');
model.study('std2').feature('stat').set('preusesol', 'auto');

model.physics('semi').prop('ModelProperties').set('Compute', 'MajorityPsi');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 1.0E-6);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', false);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol2').feature('s1').feature('aDef').set('assemtol', 0);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol2').feature('s1').feature('fc1').set('minsteprecovery', 0.001);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').set('mumpsalloc', 1.2);
model.sol('sol2').feature('s1').feature('d1').set('ooc', 'off');
model.sol('sol2').feature('s1').feature('d1').set('errorchk', 'off');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.1);
model.sol('sol2').feature('s1').feature('fc1').set('minsteprecovery', 0.001);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Electron Concentration (semi) 1');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 11, 0);
model.result('pg5').setIndex('looplevel', 3, 1);
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 11, 0);
model.result('pg5').setIndex('looplevel', 3, 1);
model.result('pg5').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg1');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('expr', 'semi.N');
model.result('pg5').feature('surf1').set('unit', '1/cm^3');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg5').feature('surf1').set('resolution', 'norefine');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Hole Concentration (semi) 1');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 11, 0);
model.result('pg6').setIndex('looplevel', 3, 1);
model.result('pg6').set('showlegendsmaxmin', true);
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 11, 0);
model.result('pg6').setIndex('looplevel', 3, 1);
model.result('pg6').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg2');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('expr', 'semi.P');
model.result('pg6').feature('surf1').set('unit', '1/cm^3');
model.result('pg6').feature('surf1').set('colortable', 'Prism');
model.result('pg6').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg6').feature('surf1').set('resolution', 'norefine');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('showsolutionparams', 'on');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').label('Electric Potential (semi) 1');
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 11, 0);
model.result('pg7').setIndex('looplevel', 3, 1);
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 11, 0);
model.result('pg7').setIndex('looplevel', 3, 1);
model.result('pg7').set('defaultPlotID', 'Semiconductor/phys3/pdef1/pcond2/pg3');
model.result('pg7').feature.create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('showsolutionparams', 'on');
model.result('pg7').feature('surf1').set('expr', 'V');
model.result('pg7').feature('surf1').set('resolution', 'norefine');
model.result('pg7').feature('surf1').set('smooth', 'internal');
model.result('pg7').feature('surf1').set('showsolutionparams', 'on');
model.result('pg7').feature('surf1').set('data', 'parent');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset2');
model.result('pg8').create('surf2', 'Surface');
model.result('pg8').create('surf1', 'Surface');
model.result('pg8').feature('surf2').set('expr', 'semi.Nnetdop');
model.result('pg8').feature('surf2').set('unit', '1/cm^3');
model.result('pg8').feature('surf2').set('coloring', 'gradient');
model.result('pg8').feature('surf2').set('colorscalemode', 'logarithmic');
model.result('pg8').feature('surf2').set('topcolor', 'red');
model.result('pg8').feature('surf2').set('bottomcolor', 'custom');
model.result('pg8').feature('surf2').set('custombottomcolor', [1 0.8 0.8]);
model.result('pg8').feature('surf2').set('smooth', 'internal');
model.result('pg8').feature('surf2').set('showsolutionparams', 'on');
model.result('pg8').feature('surf2').set('data', 'parent');
model.result('pg8').feature('surf2').set('titletype', 'none');
model.result('pg8').feature('surf2').feature.create('filt1', 'Filter');
model.result('pg8').feature('surf2').feature('filt1').set('expr', 'semi.Na-semi.Nd > 1[1/cm^3]');
model.result('pg8').feature('surf2').feature('filt1').set('useder', true);
model.result('pg8').feature('surf1').set('expr', 'semi.Nnetdop');
model.result('pg8').feature('surf1').set('unit', '1/cm^3');
model.result('pg8').feature('surf1').set('coloring', 'gradient');
model.result('pg8').feature('surf1').set('colorscalemode', 'logarithmic');
model.result('pg8').feature('surf1').set('topcolor', 'blue');
model.result('pg8').feature('surf1').set('bottomcolor', 'custom');
model.result('pg8').feature('surf1').set('custombottomcolor', [0.8 0.8 1]);
model.result('pg8').feature('surf1').set('smooth', 'internal');
model.result('pg8').feature('surf1').set('showsolutionparams', 'on');
model.result('pg8').feature('surf1').set('data', 'parent');
model.result('pg8').feature('surf1').set('titletype', 'none');
model.result('pg8').feature('surf1').feature.create('filt1', 'Filter');
model.result('pg8').feature('surf1').feature('filt1').set('expr', 'semi.Nd-semi.Na > 1[1/cm^3]');
model.result('pg8').feature('surf1').feature('filt1').set('useder', true);
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Net Dopant Concentration \vert N<sub>d</sub> - N<sub>a</sub>\vert: P-type (Red), N-type (Blue)');
model.result('pg8').set('showlegendsmaxmin', true);
model.result('pg8').set('showlegendsunit', true);
model.result('pg8').set('legendpos', 'alternating');
model.result('pg8').feature('surf2').label('P-type');
model.result('pg8').feature('surf1').label('N-type');
model.result('pg8').label('Net Dopant Concentration (semi)');
model.result('pg5').run;
model.result('pg8').run;
model.result.remove('pg8');
model.result('pg4').run;
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').set('data', 'dset2');
model.result('pg4').feature('glob2').setIndex('descr', 'Majority carriers only', 0);
model.result('pg4').feature('glob2').set('linemarker', 'asterisk');
model.result('pg4').feature('glob2').set('markerpos', 'interp');
model.result('pg4').run;
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Drain voltage (Vd)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Terminal current (A)');
model.result('pg4').run;

model.title('DC Characteristics of a MESFET');

model.description('This example compares the current-voltage characteristics of a MESFET using the majority carrier only formulation.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('mesfet.mph');

model.modelNode.label('Components');

out = model;
