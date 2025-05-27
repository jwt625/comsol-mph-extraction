function out = model
%
% boltzmann_dry_air.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Two-Term_Boltzmann_Equation');

model.modelNode.create('comp1', true);

model.physics.create('be', 'BoltzmannEquation');
model.physics('be').model('comp1');

model.study.create('std1');
model.study('std1').create('ebar', 'MeanEnergies');
model.study('std1').feature('ebar').set('solnum', 'auto');
model.study('std1').feature('ebar').set('notsolnum', 'auto');
model.study('std1').feature('ebar').set('outputmap', {});
model.study('std1').feature('ebar').setSolveFor('/physics/be', true);

model.param.set('xN2', '0.8');
model.param.descr('xN2', '');
model.param.set('xO2', '1-xN2');
model.param.descr('xO2', '');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('Ngas', '1[atm]/(k_B_const*300[K])');
model.variable('var1').descr('Ngas', '');
model.variable('var1').set('Emax', '300[V]');
model.variable('var1').descr('Emax', '');

model.physics('be').prop('EEDFSettings').set('eedf', 'BoltzmannTwoTerm');
model.physics('be').prop('EEDFSettings').set('NelemEEDF', 300);
model.physics('be').prop('EEDFSettings').set('RelemEEDF', 50);
model.physics('be').prop('EEDFSettings').set('emax', 'Emax');
model.physics('be').create('xsec1', 'CrossSectionImport', -1);
model.physics('be').feature('xsec1').set('Filepath', 'N2_phelps_xsecs_air.txt');
model.physics('be').feature('xsec1').runCommand('importData');
model.physics('be').create('xsec2', 'CrossSectionImport', -1);
model.physics('be').feature('xsec2').set('Filepath', 'O2_phelps_xsecs_air.txt');
model.physics('be').feature('xsec2').runCommand('importData');

model.nodeGroup.create('grp1', 'Physics', 'be');
model.nodeGroup('grp1').placeAfter([]);
model.nodeGroup('grp1').add('xsec1');
model.nodeGroup('grp1').add('xsec2');
model.nodeGroup('grp1').add('eir1');
model.nodeGroup('grp1').add('eir2');
model.nodeGroup('grp1').add('eir3');
model.nodeGroup('grp1').add('eir4');
model.nodeGroup('grp1').add('eir5');
model.nodeGroup('grp1').add('eir6');
model.nodeGroup('grp1').add('eir7');
model.nodeGroup('grp1').add('eir8');
model.nodeGroup('grp1').add('eir9');
model.nodeGroup('grp1').add('eir10');
model.nodeGroup('grp1').add('eir11');
model.nodeGroup('grp1').add('eir12');
model.nodeGroup('grp1').add('eir13');
model.nodeGroup('grp1').add('eir14');
model.nodeGroup('grp1').add('eir15');
model.nodeGroup('grp1').add('eir16');
model.nodeGroup('grp1').add('eir17');
model.nodeGroup('grp1').add('eir18');
model.nodeGroup('grp1').add('eir19');
model.nodeGroup('grp1').add('eir20');
model.nodeGroup('grp1').add('eir21');
model.nodeGroup('grp1').add('eir22');
model.nodeGroup('grp1').add('eir23');
model.nodeGroup('grp1').add('eir24');
model.nodeGroup('grp1').add('eir25');
model.nodeGroup('grp1').add('eir26');
model.nodeGroup('grp1').add('eir27');
model.nodeGroup('grp1').add('eir28');
model.nodeGroup('grp1').add('eir29');
model.nodeGroup('grp1').add('eir30');
model.nodeGroup('grp1').add('eir31');
model.nodeGroup('grp1').add('eir32');
model.nodeGroup('grp1').add('eir33');
model.nodeGroup('grp1').add('eir34');
model.nodeGroup('grp1').add('eir35');
model.nodeGroup('grp1').add('eir36');
model.nodeGroup('grp1').add('eir37');
model.nodeGroup('grp1').add('eir38');
model.nodeGroup('grp1').add('eir39');
model.nodeGroup('grp1').add('eir40');
model.nodeGroup('grp1').add('eir41');
model.nodeGroup('grp1').add('eir42');
model.nodeGroup('grp1').add('eir43');
model.nodeGroup('grp1').label('Electron impact reactions');

model.physics('be').feature('bmdl1').setIndex('x', 'xN2', 0, 0);
model.physics('be').feature('bmdl1').setIndex('x', 'xO2', 1, 0);
model.physics('be').feature('bmdl1').set('TownCoefPG', true);
model.physics('be').feature('bmdl1').set('RateCoefPG', false);

model.study('std1').feature('ebar').set('plist', '10^{range(log10(0.5),1/10,log10(20))}');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ebar');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ebar');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(0.5),1/10,log10(20))}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'V'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'ebar');
model.sol('sol1').feature('s1').set('control', 'ebar');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol1').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('ooc', 'auto');
model.sol('sol1').feature('s1').feature('d1').set('errorchk', 'off');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol1').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol1').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'xe_be*root.comp1.be.emax');
model.result('pg1').feature('lngr1').selection.all;
model.result('pg1').feature('lngr1').set('legend', true);
model.result('pg1').feature('lngr1').set('expr', {'be.f'});
model.result('pg1').set('titletype', 'none');
model.result('pg1').set('ylog', true);
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Energy (eV)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'EEDF (eV<sup>-3/2</sup>)');
model.result('pg1').label('EEDF (be)');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'be.ebar'});
model.result('pg2').feature('glob1').set('descr', {'Mean electron energy'});
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'be.EN');
model.result('pg2').feature('glob1').set('xdataunit', 'Td');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', 'on');
model.result('pg2').set('xlabel', 'Reduced electric field (Td)');
model.result('pg2').set('ylabelactive', 'on');
model.result('pg2').set('ylabel', 'Mean electron energy (eV)');
model.result('pg2').set('showlegends', false);
model.result('pg2').label('Mean Electron Energy (be)');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('unit', {'' '' '' ''});
model.result('pg3').feature('glob1').set('expr', {'be.muN' 'be.DeN' 'be.mueN' 'be.DenN'});
model.result('pg3').feature('glob1').set('descr', {'Reduced electron mobility' 'Reduced electron diffusivity' 'Reduced electron energy mobility' 'Reduced electron energy diffusivity'});
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'be.ebar');
model.result('pg3').set('titletype', 'none');
model.result('pg3').set('ylabelactive', 'on');
model.result('pg3').set('ylabel', 'Reduced transport properties');
model.result('pg3').label('Transport Properties (be)');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' '' '' '' '' '' '' ''  ...
'' '' ''});
model.result('pg4').feature('glob1').set('expr', {'be.alpha_1' 'be.alpha_2' 'be.alpha_3' 'be.alpha_4' 'be.alpha_5' 'be.alpha_6' 'be.alpha_7' 'be.alpha_8' 'be.alpha_9' 'be.alpha_10'  ...
'be.alpha_11' 'be.alpha_12' 'be.alpha_13' 'be.alpha_14' 'be.alpha_15' 'be.alpha_16' 'be.alpha_17' 'be.alpha_18' 'be.alpha_19' 'be.alpha_20'  ...
'be.alpha_21' 'be.alpha_22' 'be.alpha_23' 'be.alpha_24' 'be.alpha_25' 'be.alpha_26' 'be.alpha_27' 'be.alpha_28' 'be.alpha_29' 'be.alpha_30'  ...
'be.alpha_31' 'be.alpha_32' 'be.alpha_33' 'be.alpha_34' 'be.alpha_35' 'be.alpha_36' 'be.alpha_37' 'be.alpha_38' 'be.alpha_39' 'be.alpha_40'  ...
'be.alpha_41' 'be.alpha_42' 'be.alpha_43'});
model.result('pg4').feature('glob1').set('descr', {'Townsend coefficient 1: e+N2=>e+N2' 'Townsend coefficient 2: e+N2=>e+N2(rot)' 'Townsend coefficient 3: e+N2=>e+N2(v1)' 'Townsend coefficient 4: e+N2=>e+N2(v1res)' 'Townsend coefficient 5: e+N2=>e+N2(v2)' 'Townsend coefficient 6: e+N2=>e+N2(v3)' 'Townsend coefficient 7: e+N2=>e+N2(v4)' 'Townsend coefficient 8: e+N2=>e+N2(v5)' 'Townsend coefficient 9: e+N2=>e+N2(v5)' 'Townsend coefficient 10: e+N2=>e+N2(v6)'  ...
'Townsend coefficient 11: e+N2=>e+N2(v8)' 'Townsend coefficient 12: e+N2=>e+N2(A3)' 'Townsend coefficient 13: e+N2=>e+N2(A3)' 'Townsend coefficient 14: e+N2=>e+N2(B3)' 'Townsend coefficient 15: e+N2=>e+N2(W3)' 'Townsend coefficient 16: e+N2=>e+N2(A3)' 'Townsend coefficient 17: e+N2=>e+N2(B3)' 'Townsend coefficient 18: e+N2=>e+N2(a1)' 'Townsend coefficient 19: e+N2=>e+N2(a1)' 'Townsend coefficient 20: e+N2=>e+N2(w1)'  ...
'Townsend coefficient 21: e+N2=>e+N2(c3)' 'Townsend coefficient 22: e+N2=>e+N2(E3)' 'Townsend coefficient 23: e+N2=>e+N2(a1)' 'Townsend coefficient 24: e+N2=>e+N2(Sum)' 'Townsend coefficient 25: e+N2=>2e+N2+' 'Townsend coefficient 26: e+N2=>2e+N2+' 'Townsend coefficient 27: e+O2=>O+O-' 'Townsend coefficient 28: e+O2=>O+O-' 'Townsend coefficient 29: e+O2=>e+O2' 'Townsend coefficient 30: e+O2=>e+O2(rot)'  ...
'Townsend coefficient 31: e+O2=>e+O2(v1)' 'Townsend coefficient 32: e+O2=>e+O2(v1res)' 'Townsend coefficient 33: e+O2=>e+O2(v2)' 'Townsend coefficient 34: e+O2=>e+O2(v2res)' 'Townsend coefficient 35: e+O2=>e+O2(v3)' 'Townsend coefficient 36: e+O2=>e+O2(v4)' 'Townsend coefficient 37: e+O2=>e+O2(a1)' 'Townsend coefficient 38: e+O2=>e+O2(b1)' 'Townsend coefficient 39: e+O2=>e+O2(e4.5)' 'Townsend coefficient 40: e+O2=>e+O2(e6.0)'  ...
'Townsend coefficient 41: e+O2=>e+ O2(e8.4)' 'Townsend coefficient 42: e+O2=>e+O2(e9.97)' 'Townsend coefficient 43: e+O2=>2e+O2+'});
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'be.ebar');
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('ylog', 'on');
model.result('pg4').set('legendpos', 'lowerright');
model.result('pg4').feature('glob1').set('autoexpr', 'off');
model.result('pg4').feature('glob1').set('autodescr', 'on');
model.result('pg4').label('Townsend Coefficients (be)');
model.result('pg4').set('ylabel', 'Townsend coefficient (m<sup>2</sup>)');
model.result('pg1').run;
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0.1);
model.result('pg1').set('xmax', 300);
model.result('pg1').set('ymin', '1e-7');
model.result('pg1').set('ymax', 10);
model.result('pg1').set('xlog', true);
model.result('pg1').setIndex('looplevelinput', 'manual', 0);
model.result('pg1').setIndex('looplevel', [1 6 11 15 17], 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('xlog', true);
model.result('pg2').set('ylog', true);
model.result('pg3').run;
model.result('pg3').set('xlog', true);
model.result('pg3').set('ylog', true);
model.result('pg3').set('legendpos', 'lowerleft');
model.result('pg4').run;
model.result('pg4').set('axislimits', true);
model.result('pg4').set('xmin', 0);
model.result('pg4').set('xmax', 20);
model.result('pg4').set('ymin', '1e-25');
model.result('pg4').set('ymax', '2e-19');
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;
model.result('pg4').feature('glob1').set('expr', {});
model.result('pg4').feature('glob1').set('descr', {});
model.result('pg4').feature('glob1').setIndex('expr', 'be.alpha_25+be.alpha_26', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'm^2', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'N2 ionization', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'be.alpha_43', 1);
model.result('pg4').feature('glob1').setIndex('unit', 'm^2', 1);
model.result('pg4').feature('glob1').setIndex('descr', 'O2 ionization', 1);
model.result('pg4').feature('glob1').setIndex('expr', 'be.alpha_27*Ngas[cm^3]', 2);
model.result('pg4').feature('glob1').setIndex('unit', 'm^2', 2);
model.result('pg4').feature('glob1').setIndex('descr', '3-body attachment', 2);
model.result('pg4').feature('glob1').setIndex('expr', 'be.alpha_28', 3);
model.result('pg4').feature('glob1').setIndex('unit', 'm^2', 3);
model.result('pg4').feature('glob1').setIndex('descr', '2-body attachment', 3);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('N2 Rate Coefficients');
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'N2 Rate Coefficients');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('xlabel', 'Mean electron energy (V)');
model.result('pg5').set('ylabel', 'Rate coefficient (m<sup>3</sup>/s)');
model.result('pg5').set('ylog', true);
model.result('pg5').set('axislimits', true);
model.result('pg5').set('xmin', 0);
model.result('pg5').set('xmax', 20);
model.result('pg5').set('ymin', '1e-20');
model.result('pg5').set('ymax', '1e-12');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'be.k_1', 0);
model.result('pg5').feature('glob1').setIndex('unit', 'm^3/s', 0);
model.result('pg5').feature('glob1').setIndex('descr', 'Elastic', 0);
model.result('pg5').feature('glob1').setIndex('expr', 'be.k_2', 1);
model.result('pg5').feature('glob1').setIndex('unit', 'm^3/s', 1);
model.result('pg5').feature('glob1').setIndex('descr', 'Rotational', 1);
model.result('pg5').feature('glob1').setIndex('expr', 'be.k_3+be.k_4+be.k_5+be.k_6+be.k_7+be.k_8+be.k_9+be.k_10+be.k_11', 2);
model.result('pg5').feature('glob1').setIndex('unit', 'm^3/s', 2);
model.result('pg5').feature('glob1').setIndex('descr', 'Vibrational', 2);
model.result('pg5').feature('glob1').setIndex('expr', 'be.k_12+be.k_13+be.k_14+be.k_15+be.k_16+be.k_17+be.k_18+be.k_19+be.k_20+be.k_21+be.k_22+be.k_23+be.k_24', 3);
model.result('pg5').feature('glob1').setIndex('unit', 'm^3/s', 3);
model.result('pg5').feature('glob1').setIndex('descr', 'Electronic', 3);
model.result('pg5').feature('glob1').setIndex('expr', 'be.k_25+be.k_26', 4);
model.result('pg5').feature('glob1').setIndex('unit', 'm^3/s', 4);
model.result('pg5').feature('glob1').setIndex('descr', 'Ionization', 4);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'be.ebar');
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('O2 Rate Coefficients  1');
model.result('pg6').set('title', 'O2 Rate Coefficients');
model.result('pg6').run;
model.result('pg6').feature('glob1').set('expr', {});
model.result('pg6').feature('glob1').set('descr', {});
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_29', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Elastic', 0);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_30', 1);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 1);
model.result('pg6').feature('glob1').setIndex('descr', 'Rotational', 1);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_31+be.k_32+be.k_33+be.k_34+be.k_35+be.k_36', 2);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 2);
model.result('pg6').feature('glob1').setIndex('descr', 'Vibrational', 2);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_37+be.k_38+be.k_39+be.k_40+be.k_41+be.k_42', 3);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 3);
model.result('pg6').feature('glob1').setIndex('descr', 'Electronic', 3);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_43', 4);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 4);
model.result('pg6').feature('glob1').setIndex('descr', 'Ionization', 4);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_27*Ngas[cm^3]', 5);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 5);
model.result('pg6').feature('glob1').setIndex('descr', '3-body attachment', 5);
model.result('pg6').feature('glob1').setIndex('expr', 'be.k_28', 6);
model.result('pg6').feature('glob1').setIndex('unit', 'm^3/s', 6);
model.result('pg6').feature('glob1').setIndex('descr', '2-body attachment', 6);
model.result('pg6').run;
model.result.dataset.create('par1', 'Parametric1D');
model.result.dataset.create('tran1', 'Transformation2D');
model.result.dataset('tran1').set('enablescale', true);
model.result.dataset('tran1').set('scale', {'Emax/1[V]' '1'});
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').run;
model.result('pg7').label('EEDF 2D');
model.result('pg7').set('data', 'tran1');
model.result('pg7').set('titletype', 'none');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'log10(be.f)');
model.result('pg7').feature('surf1').set('colortable', 'Prism');
model.result('pg7').feature('surf1').create('hght1', 'Height');
model.result('pg7').run;
model.result.export.create('data1', 'Data');
model.result.export('data1').set('data', 'tran1');
model.result.export('data1').setIndex('expr', 'be.f', 0);
model.result.export('data1').setIndex('unit', '', 0);
model.result.export('data1').setIndex('descr', 'Electron energy distribution function', 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg6').run;
model.result('pg7').run;

model.title('Dry Air Boltzmann Analysis');

model.description('This model solves the Boltzmann equation in the two-term approximation for a mixture of nitrogen and oxygen representing a background gas of dry air. Electron transport coefficients and source terms are computed by suitable integration of the electron energy distribution function over electron impact cross sections. It is shown how to prepare the electron energy distribution function for export so that it can be used in the Plasma interface.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('boltzmann_dry_air.mph');

model.modelNode.label('Components');

out = model;
