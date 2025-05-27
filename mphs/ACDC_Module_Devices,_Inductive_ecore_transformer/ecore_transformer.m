function out = model
%
% ecore_transformer.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Inductive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study.create('std1');
model.study('std1').create('ccc', 'CoilCurrentCalculation');
model.study('std1').feature('ccc').set('CoilName', '1');
model.study('std1').feature('ccc').set('outputmap', {});
model.study('std1').feature('ccc').set('ngenAUX', '1');
model.study('std1').feature('ccc').set('goalngenAUX', '1');
model.study('std1').feature('ccc').set('ngenAUX', '1');
model.study('std1').feature('ccc').set('goalngenAUX', '1');
model.study('std1').feature('ccc').setSolveFor('/physics/mf', true);
model.study('std1').feature('ccc').setSolveFor('/physics/cir', true);

model.param.set('Rp', '100[ohm]');
model.param.descr('Rp', 'Primary side resistance');
model.param.set('Ns', '300');
model.param.descr('Ns', 'Number of turns in secondary winding');
model.param.set('nu', '50[Hz]');
model.param.descr('nu', 'Frequency of supply voltage');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').label('Variables, Case 1');
model.variable('var1').set('Rs', '10[kohm]');
model.variable('var1').descr('Rs', 'Secondary side resistance');
model.variable('var1').set('Np', '300');
model.variable('var1').descr('Np', 'Number of turns in primary winding');
model.variable('var1').set('Vac', '25[V]');
model.variable('var1').descr('Vac', 'Supply voltage');
model.variable.duplicate('var2', 'var1');
model.variable('var2').label('Variables, Case 2');
model.variable('var2').set('Rs', '100[ohm]');
model.variable('var2').set('Np', '3e5');
model.variable('var2').set('Vac', '25[kV]');

model.geom('geom1').insertFile('ecore_transformer_geom_sequence.mph', 'geom1');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Core');
model.geom('geom1').feature('ext1').set('contributeto', 'csel1');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Primary Winding');
model.geom('geom1').feature('sel1').selection('selection').set('fin', [5 6 8 9]);
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Windings');
model.geom('geom1').feature('sel1').set('contributeto', 'csel2');
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').set('fin', [3 4 7 10]);
model.geom('geom1').feature('sel2').set('contributeto', 'csel2');
model.geom('geom1').feature('sel2').label('Secondary Winding');
model.geom('geom1').run('sel2');

model.view('view1').set('renderwireframe', true);
model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([1 2 3 4 5 56]);

model.physics('mf').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.named('geom1_csel1_dom');
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf').feature('als1').create('loss1', 'LossCalculation', 3);
model.physics('mf').feature('als1').feature('loss1').set('LossModel', 'Steinmetz');
model.physics('mf').create('coil1', 'Coil', 3);
model.physics('mf').feature('coil1').selection.named('geom1_sel1');
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('CoilType', 'Numeric');
model.physics('mf').feature('coil1').set('N', 'Np');
model.physics('mf').feature('coil1').set('CoilExcitation', 'CircuitCurrent');
model.physics('mf').feature('coil1').create('loss1', 'LossCalculation', 3);
model.physics('mf').feature('coil1').feature('ccc1').feature('ct1').selection.set([35]);
model.physics('mf').create('coil2', 'Coil', 3);
model.physics('mf').feature('coil2').selection.named('geom1_sel2');
model.physics('mf').feature('coil2').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil2').set('CoilType', 'Numeric');
model.physics('mf').feature('coil2').set('N', 'Ns');
model.physics('mf').feature('coil2').set('CoilExcitation', 'CircuitCurrent');
model.physics('mf').feature('coil2').create('loss1', 'LossCalculation', 3);
model.physics('mf').feature('coil2').feature('ccc1').feature('ct1').selection.set([31]);
model.physics('mf').create('gfa1', 'GaugeFixingA', 3);
model.physics('mf').feature('gfa1').set('equationForm', 'Stationary');
model.physics('cir').create('V1', 'VoltageSource', -1);
model.physics('cir').feature('V1').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('V1').set('sourceType', 'SineSource');
model.physics('cir').feature('V1').set('value', 'Vac');
model.physics('cir').feature('V1').set('freq', 'nu');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').setIndex('Connections', 1, 1, 0);
model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.mf.VCoil_1');
model.physics('cir').create('R1', 'Resistor', -1);
model.physics('cir').feature('R1').setIndex('Connections', 0, 0, 0);
model.physics('cir').feature('R1').setIndex('Connections', 2, 1, 0);
model.physics('cir').feature('R1').set('R', 'Rp');
model.physics('cir').create('IvsU2', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU2').setIndex('Connections', 0, 1, 0);
model.physics('cir').feature('IvsU2').set('V_src', 'root.comp1.mf.VCoil_2');
model.physics('cir').create('R2', 'Resistor', -1);
model.physics('cir').feature('R2').setIndex('Connections', 0, 0, 0);
model.physics('cir').feature('R2').setIndex('Connections', 3, 1, 0);
model.physics('cir').feature('R2').set('R', 'Rs');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat2').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat2').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat2').label('Soft Iron (Without Losses)');
model.material('mat2').set('family', 'iron');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'663.146' '1';  ...
'1067.5' '1.1';  ...
'1705.23' '1.2';  ...
'2463.11' '1.3';  ...
'3841.67' '1.4';  ...
'5425.74' '1.5';  ...
'7957.75' '1.6';  ...
'12298.3' '1.7';  ...
'20462.8' '1.8';  ...
'32169.6' '1.9';  ...
'61213.4' '2';  ...
'111408' '2.1';  ...
'188487.757' '2.2';  ...
'267930.364' '2.3';  ...
'347507.836' '2.4'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat2').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat2').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat2').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat2').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat2').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat2').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
'663.146' '1.000000051691021';  ...
'1067.5' '1.4936495124126294';  ...
'1705.23' '1.9415328461315795';  ...
'2463.11' '2.257765669366018';  ...
'3841.67' '2.609980642431287';  ...
'5425.74' '2.8664452090837504';  ...
'7957.75' '3.1441438097176118';  ...
'12298.3' '3.448538051654125';  ...
'20462.8' '3.7816711973679054';  ...
'32169.6' '4.058345590113038';  ...
'61213.4' '4.420646552950275';  ...
'111408' '4.721274089545955';  ...
'188487.757' '4.972148140718701';  ...
'267930.364' '5.145510860855953';  ...
'347507.836' '5.245510861426532'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat2').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat2').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat2').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat2').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat2').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material('mat2').selection.named('geom1_csel1_dom');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2 3 4 5 6 7 8 9 10]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 6);
model.mesh('mesh1').run;

model.view('view1').set('hidestatus', 'hide');

model.study('std1').feature('ccc').set('useadvanceddisable', true);
model.study('std1').feature('ccc').set('disabledvariables', {'var2'});
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_mf_coil1_ccc1_s' 'comp1_mf_coil2_ccc1_s'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_mf_coil1_ccc1_p' 'comp1_mf_coil1_ccc1_lm' 'comp1_mf_coil2_ccc1_p' 'comp1_mf_coil2_ccc1_lm'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'itertol');
model.sol('sol1').feature('s1').feature('se1').set('segiter', 6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/mf', true);
model.study('std2').feature('time').setSolveFor('/physics/cir', true);
model.study('std2').label('Study 2, Case 1');
model.study('std2').setGenPlots(false);
model.study('std2').feature('time').set('tlist', 'range(0,5e-4,0.05)');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledvariables', {'var2'});
model.study('std2').feature('time').set('usesol', true);
model.study('std2').feature('time').set('notsolmethod', 'sol');
model.study('std2').feature('time').set('notstudy', 'std1');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'time');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,5e-4,0.05)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'Default');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 15);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('d1').label('Suggested Direct Solver () (Merged)');
model.sol('sol2').feature('t1').create('i1', 'Iterative');
model.sol('sol2').feature('t1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol2').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('t1').feature('i1').create('asamg1', 'AuxiliarySpaceAMG');
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').set('interm', {'vanka'});
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').set('vankavars', {'comp1_mf_psi'});
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('po').feature('so1').set('iter', 0);
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('t1').feature('i1').feature('asamg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 15);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('v1').set('scalemethod', 'none');
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol2').runAll;

model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.set([2 3 4 5 6 7 8 9 10]);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Magnetic Flux Density and Current');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('colortable', 'Prism');
model.result('pg1').feature('vol1').create('sel1', 'Selection');
model.result('pg1').feature('vol1').feature('sel1').selection.set([2 4 6 7 8 10]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'mf.Jx' 'mf.Jy' 'mf.Jz'});
model.result('pg1').feature('arwv1').set('descr', 'Current density');
model.result('pg1').feature('arwv1').set('xnumber', 10);
model.result('pg1').feature('arwv1').set('ynumber', 10);
model.result('pg1').feature('arwv1').set('znumber', 5);
model.result('pg1').feature('arwv1').set('color', 'blue');
model.result('pg1').feature('arwv1').set('scaleactive', true);
model.result('pg1').feature('arwv1').set('scale', '2.5e-5');
model.result('pg1').feature('arwv1').create('sel1', 'Selection');
model.result('pg1').feature('arwv1').feature('sel1').selection.named('geom1_sel1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('arwv2', 'arwv1');
model.result('pg1').run;
model.result('pg1').feature('arwv2').set('color', 'black');
model.result('pg1').feature('arwv2').set('scale', 0.0025);
model.result('pg1').run;
model.result('pg1').feature('arwv2').feature('sel1').selection.named('geom1_sel2');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Magnetic Flux Density in the Core');
model.result('pg2').set('data', 'dset2');
model.result('pg2').selection.geom('geom1', 3);
model.result('pg2').selection.named('geom1_csel1_dom');
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('quickplane', 'zx');
model.result('pg2').feature('slc1').set('quickynumber', 1);
model.result('pg2').run;
model.result('pg2').create('arwv1', 'ArrowVolume');
model.result('pg2').feature('arwv1').set('xnumber', 10);
model.result('pg2').feature('arwv1').set('ynumber', 1);
model.result('pg2').feature('arwv1').set('znumber', 10);
model.result('pg2').feature('arwv1').set('arrowtype', 'cone');
model.result('pg2').feature('arwv1').set('scaleactive', true);
model.result('pg2').feature('arwv1').set('scale', 30);
model.result('pg2').feature('arwv1').set('color', 'black');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').label('Induced Voltage in the Windings, Case 1');
model.result('pg3').set('twoyaxes', true);
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Time (seconds)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Induced voltage in primary (V)');
model.result('pg3').set('yseclabelactive', true);
model.result('pg3').set('yseclabel', 'Induced voltage in secondary (V)');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'mf.VCoil_1'});
model.result('pg3').feature('glob1').set('descr', {'Coil voltage'});
model.result('pg3').feature('glob1').set('unit', {'V'});
model.result('pg3').feature('glob1').setIndex('descr', 'Induced voltage in the primary winding', 0);
model.result('pg3').feature('glob1').set('linemarker', 'cycle');
model.result('pg3').feature('glob1').set('markerpos', 'interp');
model.result('pg3').feature('glob1').set('legendmethod', 'manual');
model.result('pg3').feature('glob1').setIndex('legends', 'VCoil_1', 0);
model.result('pg3').feature.duplicate('glob2', 'glob1');
model.result('pg3').run;
model.result('pg3').feature('glob2').setIndex('expr', 'mf.VCoil_2', 0);
model.result('pg3').feature('glob2').setIndex('descr', 'Induced voltage in the secondary winding', 0);
model.result('pg3').feature('glob2').set('plotonsecyaxis', true);
model.result('pg3').feature('glob2').setIndex('legends', 'VCoil_2', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg4').label('Current in the Windings, Case 1');
model.result('pg4').set('twoyaxes', true);
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Time (seconds)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Current in the primary winding (A)');
model.result('pg4').set('yseclabelactive', true);
model.result('pg4').set('yseclabel', 'Current in the secondary winding(V)');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'mf.ICoil_1'});
model.result('pg4').feature('glob1').set('descr', {'Coil current'});
model.result('pg4').feature('glob1').set('unit', {'A'});
model.result('pg4').feature('glob1').setIndex('descr', 'Current in the primary winding', 0);
model.result('pg4').feature('glob1').set('linemarker', 'cycle');
model.result('pg4').feature('glob1').set('markerpos', 'interp');
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'ICoil_1', 0);
model.result('pg4').feature.duplicate('glob2', 'glob1');
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('expr', 'mf.ICoil_2', 0);
model.result('pg4').feature('glob2').setIndex('descr', 'Current in the secondary winding', 0);
model.result('pg4').feature('glob2').set('plotonsecyaxis', true);
model.result('pg4').feature('glob2').setIndex('legends', 'ICoil_2', 0);
model.result('pg4').run;

model.study.create('std3');
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').setSolveFor('/physics/mf', true);
model.study('std3').feature('time').setSolveFor('/physics/cir', true);
model.study('std3').label('Study 3, Case 2');
model.study('std3').setGenPlots(false);
model.study('std3').feature('time').set('tlist', 'range(0,5e-4,0.05)');
model.study('std3').feature('time').set('useadvanceddisable', true);
model.study('std3').feature('time').set('disabledvariables', {'var1'});
model.study('std3').feature('time').set('usesol', true);
model.study('std3').feature('time').set('notsolmethod', 'sol');
model.study('std3').feature('time').set('notstudy', 'std1');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'time');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,5e-4,0.05)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('estrat', 'exclude');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('seDef', 'Segregated');
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 15);
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').label('Suggested Direct Solver () (Merged)');
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('t1').feature('i1').create('asamg1', 'AuxiliarySpaceAMG');
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').set('interm', {'vanka'});
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').set('vankavars', {'comp1_mf_psi'});
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('pr').create('so1', 'SOR');
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('pr').feature('so1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('po').create('so1', 'SOR');
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('po').feature('so1').set('iter', 0);
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('asamg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 15);
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').feature('t1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').feature('v1').set('scalemethod', 'none');
model.sol('sol3').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol3').feature('t1').set('maxstepbdf', '2.5e-4');
model.sol('sol3').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol3').feature('t1').feature('fc1').set('maxiter', 25);
model.sol('sol3').feature('t1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol3').runAll;

model.result('pg3').run;
model.result.duplicate('pg5', 'pg3');
model.result('pg5').run;
model.result('pg5').label('Induced Voltage in the Windings, Case 2');
model.result('pg5').set('data', 'dset3');
model.result('pg5').run;

model.study.create('std4');
model.study('std4').create('emloss', 'TimeToFrequencyLosses');
model.study('std4').feature('emloss').set('fftinputstudy', 'current');
model.study('std4').feature('emloss').set('lossstarttime', '0');
model.study('std4').feature('emloss').set('notsolnum', 'auto');
model.study('std4').feature('emloss').set('outputmap', {});
model.study('std4').feature('emloss').setSolveFor('/physics/mf', true);
model.study('std4').feature('emloss').setSolveFor('/physics/cir', true);
model.study.create('std5');
model.study('std5').create('emloss', 'TimeToFrequencyLosses');
model.study('std5').feature('emloss').set('fftinputstudy', 'current');
model.study('std5').feature('emloss').set('lossstarttime', '0');
model.study('std5').feature('emloss').set('notsolnum', 'auto');
model.study('std5').feature('emloss').set('outputmap', {});
model.study('std5').feature('emloss').setSolveFor('/physics/mf', true);
model.study('std5').feature('emloss').setSolveFor('/physics/cir', true);
model.study('std4').setGenPlots(false);
model.study('std4').label('Loss Calculation, Case 1');
model.study('std5').setGenPlots(false);
model.study('std5').label('Loss Calculation, Case 2');
model.study('std4').feature('emloss').set('fftinputstudy', 'std2');
model.study('std4').feature('emloss').set('useadvanceddisable', true);
model.study('std4').feature('emloss').set('disabledvariables', {'var2'});

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'emloss');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'emloss');
model.sol('sol4').create('fft1', 'FFT');
model.sol('sol4').feature('fft1').set('control', 'emloss');
model.sol('sol2').getPVals;

model.study('std4').feature('emloss').set('fftendtime', 0.05);
model.study('std4').feature('emloss').set('fftstarttime', '0.05[s]-((0.02)[s])');
model.study('std4').feature('emloss').set('fftmaxfreq', '6/((0.02)[s])');

model.sol('sol4').create('su1', 'StoreSolution');
model.sol('sol4').create('cms1', 'CombineSolution');
model.sol('sol4').feature('cms1').set('soloper', 'gensum');
model.sol('sol4').feature('cms1').setIndex('gensumexpressionactive', 'on', 19);
model.sol('sol4').feature('cms1').setIndex('gensumexpression', 'comp1.mf.Qloss', 19);
model.sol('sol4').feature('cms1').set('control', 'emloss');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.study('std5').feature('emloss').set('fftinputstudy', 'std3');
model.study('std5').feature('emloss').set('useadvanceddisable', true);
model.study('std5').feature('emloss').set('disabledvariables', {'var1'});

model.sol.create('sol6');
model.sol('sol6').study('std5');
model.sol('sol6').create('st1', 'StudyStep');
model.sol('sol6').feature('st1').set('study', 'std5');
model.sol('sol6').feature('st1').set('studystep', 'emloss');
model.sol('sol6').create('v1', 'Variables');
model.sol('sol6').feature('v1').set('control', 'emloss');
model.sol('sol6').create('fft1', 'FFT');
model.sol('sol6').feature('fft1').set('control', 'emloss');
model.sol('sol3').getPVals;

model.study('std5').feature('emloss').set('fftendtime', 0.05);
model.study('std5').feature('emloss').set('fftstarttime', '0.05[s]-((0.02)[s])');
model.study('std5').feature('emloss').set('fftmaxfreq', '6/((0.02)[s])');

model.sol('sol6').create('su1', 'StoreSolution');
model.sol('sol6').create('cms1', 'CombineSolution');
model.sol('sol6').feature('cms1').set('soloper', 'gensum');
model.sol('sol6').feature('cms1').setIndex('gensumexpressionactive', 'on', 19);
model.sol('sol6').feature('cms1').setIndex('gensumexpression', 'comp1.mf.Qloss', 19);
model.sol('sol6').feature('cms1').set('control', 'emloss');
model.sol('sol6').attach('std5');
model.sol('sol6').runAll;

model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Cycle Averaged Losses in the Core');
model.result('pg6').set('edges', false);
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Volumetric loss density, electromagnetic (W/m<sup>3</sup>): Case 1 (left), Case 2 (right)');
model.result('pg6').create('vol1', 'Volume');
model.result('pg6').feature('vol1').set('data', 'dset4');
model.result('pg6').feature('vol1').set('expr', 'mf.Qh');
model.result('pg6').feature('vol1').create('sel1', 'Selection');
model.result('pg6').feature('vol1').feature('sel1').selection.named('geom1_csel1_dom');
model.result('pg6').run;
model.result('pg6').feature('vol1').set('colortable', 'Plasma');
model.result('pg6').feature.duplicate('vol2', 'vol1');
model.result('pg6').run;
model.result('pg6').feature('vol2').set('data', 'dset6');
model.result('pg6').feature('vol2').set('colorlegend', false);
model.result('pg6').feature('vol2').set('inheritplot', 'vol1');
model.result('pg6').feature('vol2').create('trn1', 'Translation');
model.result('pg6').run;
model.result('pg6').feature('vol2').feature('trn1').set('trans', [100 -50 0]);
model.result('pg6').run;
model.result('pg6').run;
model.result.numerical.create('int1', 'IntVolume');
model.result.numerical('int1').set('data', 'dset4');
model.result.numerical('int1').selection.named('geom1_csel1_dom');
model.result.numerical('int1').setIndex('expr', 'mf.Qh', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;
model.result.numerical('int1').set('data', 'dset6');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;
model.result.numerical.duplicate('int2', 'int1');
model.result.numerical('int2').set('data', 'dset7');
model.result.numerical('int2').setIndex('expr', 'mf.Qloss', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Volume Integration 2');
model.result.numerical('int2').set('table', 'tbl2');
model.result.numerical('int2').setResult;
model.result('pg1').run;

model.title('E-Core Transformer');

model.description('This example demonstrates how to perform transient simulations of a single-phase E-core transformer. Including the effect of a nonlinear B-H curve in the soft-iron core, the example computes the spatial distribution of the magnetic and electric fields, the magnetic saturation effect, the transient response, and the flux leakage to the surroundings. Two different versions of the transformer are simulated: the first one with a turn ratio of unity and the second one with a turn ratio of 1000.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('ecore_transformer.mph');

model.modelNode.label('Components');

out = model;
